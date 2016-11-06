//
//  MMAVAudioRecordVC.m
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAVAudioRecordVC.h"
#import "MMCricleProgressView.h"

@interface MMAVAudioRecordVC ()
@property (nonatomic, strong) MMCricleProgressView *progressView;
@end

@implementation MMAVAudioRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.progressView];

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
@end
