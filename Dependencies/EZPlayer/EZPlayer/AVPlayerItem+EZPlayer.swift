//
//  AVPlayerItem+EZPlayer.swift
//  EZPlayer
//
//  Created by yangjun zhu on 2016/12/28.
//  Copyright © 2016年 yangjun zhu. All rights reserved.
//

import AVFoundation
public extension AVPlayerItem {

    var bufferDuration: TimeInterval? {
        if  let first = self.loadedTimeRanges.first { //获取缓冲进度
            let timeRange = first.timeRangeValue // 获取缓冲区域
            let startSeconds = CMTimeGetSeconds(timeRange.start)//开始的时间
            let durationSecound = CMTimeGetSeconds(timeRange.duration)//表示已经缓冲的时间
            let result = startSeconds + durationSecound // 计算缓冲总时间
            return result
        }
        return nil
    }

    
    /// 获取／设置当前subtitle／cc
    var selectedMediaCharacteristicLegibleOption:AVMediaSelectionOption?{
        get{
            if let legibleGroup = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible){
                return self.selectedMediaOption(in: legibleGroup)
            }
            return nil
        }
        set{
            if let legibleGroup = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible){
                self.select(newValue, in: legibleGroup)
            }
        }
    }

    /// 获取／设置当前cc
    var selectedClosedCaptionOption:AVMediaSelectionOption?{
        get{
            if let option = self.selectedMediaCharacteristicLegibleOption{
                if option.mediaType == .closedCaption {
                    return option
                }
            }
            return nil
        }
        set{
            if let legibleGroup = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible){
                if newValue == nil{
                    self.select(newValue, in: legibleGroup)
                }else if newValue!.mediaType == .closedCaption {
                    self.select(newValue, in: legibleGroup)
                }
            }
        }
    }

    /// 获取／设置当前subtitle
    var selectedSubtitleOption:AVMediaSelectionOption?{
        get{
            if let option = self.selectedMediaCharacteristicLegibleOption{
                if !option.hasMediaCharacteristic(AVMediaCharacteristic.containsOnlyForcedSubtitles) {
                    return option
                }
            }
            return nil
        }
        set{
            if let legibleGroup = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible){
                if newValue == nil{
                    self.select(newValue, in: legibleGroup)
                }else if !newValue!.hasMediaCharacteristic(AVMediaCharacteristic.containsOnlyForcedSubtitles) {
                    self.select(newValue, in: legibleGroup)
                }
            }
        }
    }

    /// 获取／设置当前audio
    var selectedMediaCharacteristicAudibleOption:AVMediaSelectionOption?{
        get{
            if let group = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.audible){
                return self.selectedMediaOption(in: group)
            }
            return nil
        }
        set{
            if let group = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.audible){
                self.select(newValue, in: group)
            }
        }
    }

}
