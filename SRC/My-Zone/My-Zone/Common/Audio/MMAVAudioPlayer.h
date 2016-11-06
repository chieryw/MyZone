//
//  MMAVAudioPlayer.h
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMAVAudioPlayerDelegate <NSObject>

- (void)playFinish;
- (void)playError;

@end

@interface MMAVAudioPlayer : NSObject

/**
 声音
 */
@property (nonatomic, assign) CGFloat volume;

/**
 播放进度
 */
@property (nonatomic, assign) CGFloat progress;


/**
 播放完成回调
 */
@property (nonatomic, weak) id<MMAVAudioPlayerDelegate>delegate;


/**
 当期那播放进度用于外界监听
 */
@property (nonatomic, readonly) CGFloat currentProgress;


/**
 用文件的名称来初始化对象

 @param name 文件名称
 @return 实例对象
 */
- (instancetype)initWithAudioFileName:(NSString *)name;


/**
 播放声音
 */
- (void)play;


/**
 停止播放
 */
- (void)pause;

@end
