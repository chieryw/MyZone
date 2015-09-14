//
//  MMPhoneCheckVM.m
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMPhoneCheckVM.h"

@implementation MMPhoneCheckVM

- (instancetype)initWithModel:(id)sender {

    self = [super init];
    if (self) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf {

    _userName = @"";
    _password = @"";
    _checkSelected = NO;
    _checkString = @"";
    _introViewNeedShow = NO;
    _introViewModel = [[MMIntroViewModel alloc] init];
    
}

@end
