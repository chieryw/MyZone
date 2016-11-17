//
//  MMAVPlayer.h
//  My-Zone
//
//  Created by chiery on 2016/11/17.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, MMAVPlayerStatus) {
    MMAVPlayerStatusLoading,
    MMAVPlayerStatusLoadingError,
    MMAVPlayerStatusPlayError,
    MMAVPlayerStatusReadyToPlay,
    MMAVPlayerStatusPlaying,
    MMAVPlayerStatusPause,
    MMAVPlayerStatusPlayFinished,
};

@interface MMAVPlayer : NSObject

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat volume;
@property (nonatomic, assign) CGFloat loadedProgress;
@property (nonatomic, assign) MMAVPlayerStatus status;


- (instancetype)initWithURL:(NSURL *)url;
- (void)play;
- (void)pause;
- (void)seekProgress:(CGFloat)progress;

@end
