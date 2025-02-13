import Foundation
import AVFoundation
import AVRouting
import os
import AlamofireImage
import Foil

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "DownloadManager")

struct DownloadMediaItem: Codable {
    let title: String
    let sourceURL: URL

    let posterURL: URL?

    let season: Int?
    let episode: Int?

    func posterData() async throws -> Data? {
        guard let posterURL else { return nil }

        return try await withCheckedThrowingContinuation { continuation in
            ImageDownloader.default.download(URLRequest(url: posterURL), completion:  { resp in
                let result = resp.result.map({ $0.jpegData(compressionQuality: 1) })
                continuation.resume(with: result)
            })
        }
    }
}

class DownloadManager: NSObject, AVAssetDownloadDelegate {

    enum TaskStatus: Codable {
        case initialized
        case downloading
        case paused
        case completed
        case canceled
    }

    struct DownloadTask<Entity: Codable>: Codable, Identifiable {
        let id: String
        
        let destinationURL: URL

        let item: Entity

        var status: TaskStatus = .initialized
    }

//    @MainActor
    var startingTasks: [Int: DownloadMediaItem] = [:]
    var downloadingTasks: [Int: DownloadTask<DownloadMediaItem>] = [:]

    static let shared = DownloadManager()

    /// The `AVAssetDownloadURLSession` to use for managing `AVAssetDownloadTasks`.
    fileprivate var assetDownloadURLSession: AVAssetDownloadURLSession!

    let knownDownloadsKey = "knownDownloads"
    public var knownDownloads: [String: Data] = [:]

    func addDownload(_ url: URL, title: String) {
        knownDownloads[title] = try? url.bookmarkData()
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(knownDownloads, forKey: knownDownloadsKey)
    }

    private override init() {
        super.init()

        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "AAPL-Identifier")

        /// Create the `AVAssetDownloadURLSession` using the configuration.
        assetDownloadURLSession =
            AVAssetDownloadURLSession(configuration: backgroundConfiguration,
                                      assetDownloadDelegate: self, delegateQueue: OperationQueue.main)

        let userDefaults = UserDefaults.standard

        knownDownloads = userDefaults.value(forKey: knownDownloadsKey) as? [String: Data] ?? [:]
        logger.info("Known downloads: \(self.knownDownloads)")
    }

    func resumeDownloads() {
        assetDownloadURLSession.getAllTasks { [weak self, logger] activeTasks in
            guard let self else { return }
            for task in activeTasks {
                restoreTask(task)
            }

            logger.info("Active tasks: \(activeTasks.count)")
        }
    }

    func restoreTask(_ task: URLSessionTask) {
        guard let task = task as? AVAssetDownloadTask else { return }

        let handler = task.progress.observe(\.fractionCompleted) { [logger] (progress, _) in
            logger.debug("[\(task.taskIdentifier)] Progress: \(progress.fractionCompleted)")
        }

        handlers.insert(handler)

    }

    var handlers: Set<NSKeyValueObservation> = []

    func loadMediaTracks(asset: AVURLAsset) {
        Task {
            let mediaSelections = try await asset.load(.allMediaSelections)
            for selection in mediaSelections {
                
                logger.info("Media selection: \(selection)")
            }
            logger.info("Media selections count: \(mediaSelections.count)")

            let subtitles = try await asset.loadMediaSelectionGroup(for: .audible)
            logger.info("Subtitles: \(subtitles)")

//            asset.load(.trackGroups)
        }

    }


    func startDownloading(item: DownloadMediaItem) {
        Task {
            logger.info("Planning download for \(item.title)")

            let asset = AVURLAsset(url: item.sourceURL)

            let downloadConfiguration = AVAssetDownloadConfiguration(asset: asset,
                                                                     title: item.title)
            downloadConfiguration.artworkData = try? await item.posterData()
            logger.info("Poster was loaded for \(item.title): \(downloadConfiguration.artworkData?.count ?? 0) bytes")

            try? await selectAssetTracks(asset: asset, downloadConfiguration: downloadConfiguration)

            let task = assetDownloadURLSession.makeAssetDownloadTask(downloadConfiguration: downloadConfiguration)
            task.taskDescription = item.title

            let handler = task.progress.observe(\.fractionCompleted) { [logger] (progress, _) in
                logger.debug("Title: \(item.title), Progress: \(progress.fractionCompleted)")
            }

            handlers.insert(handler)


            await MainActor.run {
                startingTasks[task.taskIdentifier] = item
            }
            task.resume()
        }
    }

    func selectAssetTracks(asset: AVURLAsset, downloadConfiguration: AVAssetDownloadConfiguration) async throws {
//        var mediaSelections: [AVMediaSelection] = []
//        let characteristics = try await asset.load(.availableMediaCharacteristicsWithMediaSelectionOptions)
//        for characteristic in characteristics {
//            print("\(characteristic)")
//
//            let group = try await asset.loadMediaSelectionGroup(for: characteristic)
//
//            if let group {
//                let groupSelections = group.options.map { option in
//                    print("Option: \(option.displayName)")
//                    let selection = AVMutableMediaSelection()
////                    selection.select(option, in: group)
//                    return selection
//                }
//                mediaSelections.append(contentsOf: groupSelections)
//            }
//
//        }


        let primaryContent = downloadConfiguration.primaryContentConfiguration
//        primaryContent.variantQualifiers = [
//            AVAssetVariantQualifier(predicate: AVAssetVariantQualifier.predicate(forPresentationWidth: 480, operatorType: .lessThanOrEqualTo)),
//            AVAssetVariantQualifier(predicate: AVAssetVariantQualifier.predicate(forPresentationWidth: 800, operatorType: .lessThanOrEqualTo)),
//
//        ]

        let mediaSelections = try await asset.load(.allMediaSelections)
//        primaryContent.mediaSelections = mediaSelections
        primaryContent.mediaSelections = mediaSelections
    }

    func urlSession(
        _ session: URLSession,
        assetDownloadTask: AVAssetDownloadTask,
        didResolve resolvedMediaSelection: AVMediaSelection
    ) {
        logger.info("\(#function), resolvedMediaSelection: \(resolvedMediaSelection)")
    }

    func urlSession(_ session: URLSession, assetDownloadTask: AVAssetDownloadTask, willDownloadTo location: URL) {
        logger.info("\(#function), location: \(location)")
        guard let item = startingTasks[assetDownloadTask.taskIdentifier] else { return }

        downloadingTasks[assetDownloadTask.taskIdentifier] = DownloadTask(
            id: UUID().uuidString,
            destinationURL: location,
            item: item)
    }

    func urlSession(
        _ session: URLSession,
        assetDownloadTask: AVAssetDownloadTask,
        willDownloadVariants variants: [AVAssetVariant]
    ) {
        let variantsDescription = variants.map { variant -> String in
            guard let peakBitRate = variant.peakBitRate else { return "N/A" }
            guard let resolution = variant.videoAttributes?.presentationSize else { return "N/A" }
            return "peakBitRate=\(peakBitRate) & resolution=\(Int(resolution.width)) x \(Int(resolution.height))"
        }.joined(separator: ", ")

        /*
         Use this delegate callback to display or record
         the variants that the download task downloads.
         */
        logger.info("Will download the following variants: \(variantsDescription)")
    }

    func urlSession(
        _ session: URLSession,
        assetDownloadTask: AVAssetDownloadTask,
        didFinishDownloadingTo location: URL
    ) {
        logger.info("\(#function), location: \(location), taskIdentifier: \(assetDownloadTask.taskIdentifier)")
        addDownload(location, title: assetDownloadTask.taskDescription ?? "Unknown")
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        guard let assetTask = task as? AVAssetDownloadTask else { return }
        logger.info("didCompleteWithError, asset.url: \(assetTask.urlAsset.url)")
        if let error {
            logger.error("Error: \(error)")
        }

        let titleSuffix = error != nil ? " с ошибкой" : ""
        sendLocalNotification(title: "Загрузка завершена" + titleSuffix,
                              body: error?.localizedDescription ?? task.taskDescription ?? String(task.taskIdentifier))
    }
}
