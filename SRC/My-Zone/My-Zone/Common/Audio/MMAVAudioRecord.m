//
//  MMAVAudioRecord.m
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVAudioRecord.h"
#import <AVFoundation/AVFoundation.h>

#define kRecordAudioFile @"myRecord.caf"

static const CGFloat recordTimerInterval = 0.08;

@interface MMAVAudioRecord ()<AVAudioRecorderDelegate>
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, readwrite) CGFloat currentVolume;
@end

@implementation MMAVAudioRecord

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setAudioSession];
    }
    return self;
}

-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

- (NSURL *)getSavePath {
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}


- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _recorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _recorder.delegate=self;
        _recorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        [_recorder prepareToRecord];
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _recorder;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:recordTimerInterval block:^(NSTimer * _Nonnull timer) {
            [self getVolumeInfo];
        } repeats:YES];
    }
    return _timer;
}

- (void)getVolumeInfo {
    [self.recorder updateMeters];//更新测量值
    float power= [self.recorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    self.currentVolume = (1.0/160.0)*(power+160.0);
    NSLog(@"正在输出音量:%f",self.currentVolume);
}

- (void)start {
    if (!self.recorder.isRecording) {
        [self.recorder record];
        self.timer.fireDate = [NSDate date];
    }
}

- (void)pause {
    if (self.recorder.isRecording) {
        [self.recorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)resume {
    [self start];
}

- (void)stop {
    [self.recorder stop];
    self.timer.fireDate = [NSDate distantFuture];
}

#pragma mark - 录音机代理方法
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音完成!");
}

@end
