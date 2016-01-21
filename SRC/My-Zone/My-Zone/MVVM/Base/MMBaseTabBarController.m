//
//  MMBaseTabBarController.m
//  My-Zone
//
//  Created by chiery on 15/10/18.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMBaseTabBarController.h"
#import "MMIntroView.h"
#import "MMIntroViewModel.h"
#import "MMAppSetting.h"


@interface MMBaseTabBarController ()

@property (nonatomic, strong) MMIntroView *introView;


@end

@implementation MMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 基本配置
    [self configureSelf];
    
    // 相关配置
    [[MMAppSetting getInstance] configureIntroView];
    
    // introView
    [self addIntroView];
    
    // 登录状态检测
    [self checkUserLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 基本配置
- (void)configureSelf {
    self.tabBar.tintColor = [UIColor whiteColor];
    
}

- (void)checkUserLogin {
    
}

#pragma mark - introView
- (void)addIntroView {
    
    NSNumber *isfirstEnter = [[NSUserDefaults standardUserDefaults] valueForKey:MMApplicationFirstEnter];
    if (isfirstEnter && isfirstEnter.boolValue) {
        
        [self.view addSubview:self.introView];
    }
    
}

- (MMIntroView *)introView {
    
    if (!_introView) {
        
        _introView = [[MMIntroView alloc] init];
        
        MMIntroViewModel *model = [[MMIntroViewModel alloc] init];
        _introView.model = model;
        
        __weak typeof(self) weakSelf = self;
        [[_introView.enterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            // 将首次进入的标志删除
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:MMApplicationFirstEnter];
            [weakSelf performSegueWithIdentifier:@"NeedUserInfo" sender:nil];
        }];
    }
    
    return _introView;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
