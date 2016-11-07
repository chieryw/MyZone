//
//  MMAVAudioRecord.h
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAVAudioRecord : NSObject


/**
 将声音信息透传出去,每0.1秒透传一次
 */
@property (nonatomic, readonly) CGFloat currentVolume;


/**
 开始录制声音
 */
- (void)start;

/**
 暂停录制声音，重新开始会在原有的基础上追加录音的信息
 */
- (void)pause;

/**
 与pause结合使用，在pause暂停的基础上追加录音数据
 */
- (void)resume;

/**
 停止录制声音，这个动作会触发代理方法，录制已经结束
 */
- (void)stop;

@end
