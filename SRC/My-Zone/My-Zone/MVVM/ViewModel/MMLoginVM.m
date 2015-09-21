//
//  MMPhoneCheckVM.m
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMLoginVM.h"

@implementation MMLoginVM

- (instancetype)init {

    self = [super init];
    if (self) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf {

    self.userName = @"";
    self.password = @"";
    self.checkSelected = NO;
    self.checkString = @"";

    NSNumber *enterType = [[NSUserDefaults standardUserDefaults] valueForKey:MMApplicationFirstEnter];
    self.enterType = enterType.boolValue?MMEnterTypeRegister:MMEnterTypeLogin;
    
}

@end
