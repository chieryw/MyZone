//
//  MMIntroViewModel.m
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMIntroViewModel.h"
#import <UIKit/UIKit.h>

@implementation MMIntroViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {

    _images = @[
                [UIImage imageNamed:@"BackImage1"],
                [UIImage imageNamed:@"BackImage1"],
                [UIImage imageNamed:@"BackImage1"],
                [UIImage imageNamed:@"BackImage1"]
                ];
    
}

@end
