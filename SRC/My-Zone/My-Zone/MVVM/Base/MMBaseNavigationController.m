//
//  MMBaseNavigationController.m
//  My-Zone
//
//  Created by chiery on 15/9/20.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMBaseNavigationController.h"

@interface MMBaseNavigationController ()

@property (nonatomic, assign) BOOL pop;

@end

@implementation MMBaseNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureSelf {
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
