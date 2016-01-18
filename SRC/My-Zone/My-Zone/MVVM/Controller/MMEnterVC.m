//
//  MMEnterVC.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEnterVC.h"

@interface MMEnterVC ()

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@",sender);
    NSLog(@"%@",segue);
}

@end
