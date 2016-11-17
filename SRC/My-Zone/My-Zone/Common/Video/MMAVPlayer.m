//
//  MMAVPlayer.m
//  My-Zone
//
//  Created by chiery on 2016/11/17.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVPlayer.h"

@interface MMAVPlayer ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *loadURL;
@end

@implementation MMAVPlayer

- (void)dealloc {
    [self removeNotification];
}

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.loadURL = url;
        [self initSelf];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.status = MMAVPlayerStatusLoading;
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self addNotification];
    [self addProgressObserver];
    [self addObserverToPlayerItem:self.player.currentItem];
    self.volume = self.player.volume;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)playbackFinished:(NSNotification *)notification {
    self.status = MMAVPlayerStatusPlayFinished;
    
    [self seekProgress:0];
    self.progress = 0;
}

- (void)addProgressObserver {
    @weakify(self);
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        @strongify(self);
        [self updateProgress:time];
    }];
}

- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        [self updateStatus:status];
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        AVPlayerItem *playerItem = object;
        [self updateLoadedTimeRanges:playerItem];
    }
}

- (void)updateProgress:(CMTime)time {
    AVPlayerItem *playerItem=self.player.currentItem;
    float current=CMTimeGetSeconds(time);
    float total=CMTimeGetSeconds([playerItem duration]);
    if (current)self.progress = current/total;
}

- (void)updateStatus:(NSInteger)status {
    switch (status) {
        case AVPlayerStatusUnknown:
        case AVPlayerStatusFailed:
            self.status = MMAVPlayerStatusLoadingError;
            break;
        case AVPlayerStatusReadyToPlay:
            self.status = MMAVPlayerStatusReadyToPlay;
            break;
            
        default:
            break;
    }
}


- (void)updateLoadedTimeRanges:(AVPlayerItem *)playerItem {
    NSArray *array=playerItem.loadedTimeRanges;
    CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
    float total = CMTimeGetSeconds(playerItem.duration);
    if (total) self.loadedProgress = totalBuffer/total;
}

- (void)setVolume:(CGFloat)volume {
    if (_volume != volume) _volume = volume;
    self.player.volume = volume;
}

- (void)seekProgress:(CGFloat)progress {
    float total = CMTimeGetSeconds(self.player.currentItem.duration);
    float seekTime = total * progress;
    CMTime time = CMTimeMake(seekTime, 1);
    [self.player.currentItem seekToTime:time];
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] initWithURL:self.loadURL];
    }
    return _player;
}

- (void)play {
    if (self.status == MMAVPlayerStatusReadyToPlay ||
        self.status == MMAVPlayerStatusPause ||
        self.status == MMAVPlayerStatusPlayFinished) {
        self.status = MMAVPlayerStatusPlaying;
        [self.player play];
    }
}

- (void)pause {
    if (self.status == MMAVPlayerStatusPlaying) {
        self.status = MMAVPlayerStatusPause;
        [self.player pause];
    }
}

@end
