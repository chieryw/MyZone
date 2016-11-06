//
//  MMSystemSoundServieVC.m
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSystemSoundServieVC.h"
#import "MMSystemSoundServie.h"

@interface MMSystemSoundServieVC ()

@end

@implementation MMSystemSoundServieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    [[MMSystemSoundServie getInstance] playSoundWithName:@"alert.wav"
                                     palySystemSoundType:MMPlaySystemSoundTypeDefault
                                          completeHandle:^(SystemSoundID soundID, void *clientData) {
                                              NSLog(@"播放结束了 soundID:%u，clientData:%@",(unsigned int)soundID,clientData);
                                          }];
}

- (IBAction)playAlert:(id)sender {
    [[MMSystemSoundServie getInstance] playSoundWithName:@"alert.wav"
                                     palySystemSoundType:MMPlaySystemSoundTypeAlert
                                          completeHandle:^(SystemSoundID soundID, void *clientData) {
                                              NSLog(@"播放结束了 soundID:%u，clientData:%@",(unsigned int)soundID,clientData);
                                          }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
