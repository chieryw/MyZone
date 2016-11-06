//
//  MMAVAudioPlayer.m
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface MMAVAudioPlayer ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, readwrite) CGFloat currentProgress;
@end

@implementation MMAVAudioPlayer

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 初始化对象

 @param name 播放文件的名称
 @return 播放对象
 */
- (instancetype)initWithAudioFileName:(NSString *)name {
    if (self = [super init]) {
        _fileName = name;
        [self initSelf];
    }
    return self;
}


/**
 设置默认值
 */
- (void)initSelf {
    _progress = 0;
    _volume = 0.3;
}


/**
 初始化player对象

 @return player对象
 */
- (AVAudioPlayer *)player {
    if (!_player) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:nil];
        NSURL *fileURL = [NSURL URLWithString:filePath];
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        if (error) {
            NSLog(@"出错了");
            return nil;
        }
        
        _player.numberOfLoops = 0;
        _player.delegate = self;
        _player.currentTime = self.progress;
        _player.volume = self.volume;
        [_player prepareToPlay];
    }
    return _player;
}


/**
 定时器，监听播放进度

 @return 定时器
 */
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer * _Nonnull timer) {
            [self playing];
        } repeats:YES];
    }
    return _timer;
}


/**
 播放中
 */
- (void)playing {
    self.currentProgress = (self.player.currentTime / self.player.duration);
}


/**
 播放完成
 */
- (void)playFinish {
    self.progress = 0;
    [self pause];
    [self.timer setFireDate:[NSDate distantFuture]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(playFinish)])
        [self.delegate playFinish];
}


/**
 设置播放进度

 @param Progress 播放进度
 */
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = progress;
        self.player.currentTime = progress * self.player.duration;
    }
}


/**
 设置播放器声音

 @param volume 声音
 */
- (void)setVolume:(CGFloat)volume {
    if (_volume != volume) {
        _volume = volume;
        self.player.volume = volume;
    }
}


/**
 播放
 */
- (void)play {
    if (self.player && [self.player prepareToPlay]) {
        [self.player play];
        [self.timer setFireDate:[NSDate date]];
    }
}


/**
 暂定播放
 */
- (void)pause {
    if (self.player && self.player.isPlaying) {
        [self.player pause];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

#pragma mark - delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self playFinish];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"发生错误");
}

@end
