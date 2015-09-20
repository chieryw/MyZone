//
//  AppDelegate.m
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "AppDelegate.h"
#import "MMAppSetting.h"
#import "MMIntroView.h"
#import "MMBaseNavigationController.h"
#import "MMIntroViewModel.h"

@interface AppDelegate ()

@property (nonatomic, strong) MMIntroView *introView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 配置对应的UI显示
    [self configureApplication:application];
    
    // 相关配置
    [[MMAppSetting getInstance] configureIntroView];
    
    // 初始化window
    [self initWindow];
    
    // 初始化RootView
    [self initRootViewController];
    
    // 初始化IntroView
    [self addIntroView];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

#pragma mark - 辅助函数
// 做一些UI上的预设置
- (void)configureApplication:(UIApplication *)application {

    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:[UIFont MMTextFont12],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }
                                                forState:UIControlStateNormal];
    
}

- (void)initWindow {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}

- (void)addIntroView {

    NSNumber *isfirstEnter = [[NSUserDefaults standardUserDefaults] valueForKey:MMApplicationFirstEnter];
    if (isfirstEnter && isfirstEnter.boolValue) {
       
        [self.window addSubview:self.introView];
    }
    
}

- (MMIntroView *)introView {

    if (!_introView) {
        
        _introView = [[MMIntroView alloc] init];
        
        MMIntroViewModel *model = [[MMIntroViewModel alloc] init];
        _introView.model = model;
        
        [[_introView.enterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            // 将首次进入的标志删除
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:MMApplicationFirstEnter];
        }];
    }
    
    return _introView;
    
}

- (void)initRootViewController {

    if (YES) {
        UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        MMBaseNavigationController *loginNavigation = [loginStoryBoard instantiateViewControllerWithIdentifier:@"LoginNavigationC"];
        [self.window setRootViewController:loginNavigation];
    }
    
}

@end
