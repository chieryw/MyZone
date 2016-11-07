//
//  MMAVAudioRecordVC.m
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVAudioRecordVC.h"
#import "MMCricleProgressView.h"
#import "MMRecordRadioLayer.h"
#import "MMAVAudioRecord.h"
#import "MMAVAudioPlayer.h"

@interface MMAVAudioRecordVC ()<MMAVAudioPlayerDelegate>
@property (nonatomic, strong) MMCricleProgressView *progressView;
@property (nonatomic, strong) UIButton *recorderButton;
@property (nonatomic, strong) MMAVAudioRecord *audioRecord;
@property (nonatomic, strong) MMAVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat recorderProgress;
@end

@implementation MMAVAudioRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.recorderButton];
    
    [self RACBind];
}

- (void)RACBind {
    [RACObserve(self.audioRecord, currentVolume) subscribeNext:^(id x) {
        MMRecordRadioLayer *radioLayer = [MMRecordRadioLayer layer];
        radioLayer.frame = CGRectMake(0, 0, 280, 280);
        radioLayer.center = self.view.center;
        radioLayer.volume = [x floatValue];
        [radioLayer startAnimation];
        [self.view.layer addSublayer:radioLayer];
    }];
    [RACObserve(self, recorderProgress) subscribeNext:^(id x) {
        self.progressView.progress = [x floatValue]/60;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MMCricleProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[MMCricleProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _progressView.center = self.view.center;
        _progressView.progress = 0.0f;
    }
    return _progressView;
}

- (UIButton *)recorderButton {
    if (!_recorderButton) {
        _recorderButton = [UIButton new];
        _recorderButton.frame = CGRectMake(0, 0, 300, 300);
        _recorderButton.center = self.view.center;
        [_recorderButton setTitle:@"按住录音" forState:UIControlStateNormal];
        [_recorderButton setTitle:@"正在录音" forState:UIControlStateSelected];
        [_recorderButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_recorderButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [_recorderButton addTarget:self action:@selector(startRecorder) forControlEvents:UIControlEventTouchDown];
        [_recorderButton addTarget:self action:@selector(stopRecorder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recorderButton;
}

- (MMAVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        _audioPlayer = [[MMAVAudioPlayer alloc] initWithContentOfURL:[self getSavePath]];
        _audioPlayer.delegate = self;
    }
    return _audioPlayer;
}

- (MMAVAudioRecord *)audioRecord {
    if (!_audioRecord) {
        _audioRecord = [MMAVAudioRecord new];
    }
    return _audioRecord;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 block:^(NSTimer * _Nonnull timer) {
            [self updateRecorderProgress];
        } repeats:YES];
    }
    return _timer;
}

- (void)updateRecorderProgress {
    if (self.recorderProgress > 60) {
        [self stopRecorder];
        return;
    }
    self.recorderProgress += 0.02;
}

- (NSURL *)getSavePath {
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:@"myRecord.caf"];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

- (void)startRecorder {
    self.recorderButton.selected = YES;
    self.recorderProgress = 0.0f;
    [self.audioRecord start];
    [self.timer setFireDate:[NSDate date]];
}

- (void)stopRecorder {
    self.recorderButton.selected = NO;
    self.recorderProgress = 0.0f;
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.audioRecord stop];
}

- (IBAction)play:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.audioPlayer pause];
    }
    else {
        sender.selected = YES;
        [self.audioPlayer play];
    }
}

#pragma mark - MMAVAudioPlayerDelegate
- (void)playFinish {
    self.playButton.selected = NO;
}

- (void)playError {
    self.playButton.selected = NO;
}

@end
