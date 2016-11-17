//
//  MMAVPlayerVC.m
//  My-Zone
//
//  Created by chiery on 2016/11/17.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVPlayerVC.h"
#import "MMAVPlayer.h"

@interface MMAVPlayerVC ()
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIView *bottomViewBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *headerBackgroundView;
@property (nonatomic, strong) MMAVPlayer *player;
@property (weak, nonatomic) IBOutlet UIImageView *sceenView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation MMAVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSelf];
    [self bindRAC];
}

- (void)bindRAC {
    @weakify(self)
    [RACObserve(self.player, volume) subscribeNext:^(id x) {
        @strongify(self);
        [self.volumeSlider setValue:[x floatValue]];
    }];
    [RACObserve(self.player, progress) subscribeNext:^(id x) {
        @strongify(self);
        [self.progressSlider setValue:[x floatValue]];
    }];
    [RACObserve(self.player, status) subscribeNext:^(id x) {
        @strongify(self);
        [self updateUI];
    }];
}


- (void)updateUI {
    switch (self.player.status) {
        case MMAVPlayerStatusLoading:
            MBProgressHUDShowInSelfWithAnimation
            break;
        case MMAVPlayerStatusReadyToPlay:
            MBProgressHUDHideWithAnimation
        case MMAVPlayerStatusPlayFinished:
            self.playButton.selected = NO;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initSelf {
    self.headerBackgroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
    self.bottomViewBackgroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
    AVPlayerLayer *layer = self.player.playerLayer;
    layer.frame = self.sceenView.bounds;
    [self.sceenView.layer addSublayer:layer];
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

- (IBAction)progressChanges:(UISlider *)sender {
    [self.player seekProgress:sender.value];
}

- (IBAction)volumeChanged:(UISlider *)sender {
    [self.player setVolume:sender.value];
}


- (IBAction)play:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.player pause];
    }
    else {
        sender.selected = YES;
        [self.player play];
    }
}

- (MMAVPlayer *)player {
    if (!_player) {
        _player = [[MMAVPlayer alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/download/video/TestVideo.mp4",MMDebugUrl]]];
    }
    return _player;
}


@end
