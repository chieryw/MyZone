//
//  MMAVAudioPlayerVC.m
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVAudioPlayerVC.h"

@interface MMAVAudioPlayerVC ()
@property (weak, nonatomic) IBOutlet UISlider *processSlider;
@property (weak, nonatomic) IBOutlet UIView *processSliderBackgroundView;
@property (weak, nonatomic) IBOutlet UISlider *audioVolumeSlider;
@property (weak, nonatomic) IBOutlet UIView *bottomBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) MMAVAudioPlayer *player;
@end

@implementation MMAVAudioPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSelf];
    [self observePlayerProcess];
}

- (void)observePlayerProcess {
    [RACObserve(self.player, currentProgress) subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.processSlider.value = [x floatValue];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSelf {
    self.processSliderBackgroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
    self.bottomBackgroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews.firstObject setAlpha:1];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (IBAction)processSlider:(UISlider *)sender {
    self.player.progress = sender.value;
}

- (IBAction)volumeSlider:(UISlider *)sender {
    self.player.volume = sender.value;
}

- (IBAction)preAction:(id)sender {
    
}

- (IBAction)playAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.player pause];
    }
    else {
        sender.selected = YES;
        [self.player play];
    }
}

- (IBAction)forwardAction:(id)sender {
    
}


- (MMAVAudioPlayer *)player {
    if (!_player) {
        _player = [[MMAVAudioPlayer alloc] initWithAudioFileName:@"jazz.mp3"];
        _player.delegate = self;
    }
    return _player;
}

- (void)playFinish {
    self.processSlider.value = 0;
    self.playButton.selected = NO;
}

- (void)playError {
    self.processSlider.value = 0;
    self.playButton.selected = NO;
    [UIAlertView tipMessage:@"播放出错了！"];
}

@end
