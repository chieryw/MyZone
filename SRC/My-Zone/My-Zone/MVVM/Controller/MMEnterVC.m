//
//  MMEnterVC.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEnterVC.h"

@interface MMEnterVC ()<UIAlertViewDelegate>
@property (nonatomic, assign) BOOL isGuide;   // 是否选中了导游
@end

@implementation MMEnterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)guideEnter:(id)sender {
    self.isGuide = YES;
    [self tip];
}

- (IBAction)visitorEnter:(id)sender {
    self.isGuide = NO;
    [self tip];
}

- (void)tip {
    [UIAlertView showTitle:@"你确定选择该身份吗" message:@"我是导游，我可以带别人去旅行\n我是游客，我需要别人带我去旅游" delegate:self cancelButtonTitle:@"重选" otherButtonTitles:@"确定"];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self performSegueWithIdentifier:@"EnterPersonCenter" sender:nil];
    }
}

@end
