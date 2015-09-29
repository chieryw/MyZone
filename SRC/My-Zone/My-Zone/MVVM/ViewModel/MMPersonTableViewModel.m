//
//  MMPersonTableViewModel.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonTableViewModel.h"

@interface MMPersonTableViewModel ()

@property (nonatomic, strong) NSMutableArray *cellConfigArray;

@end

@implementation MMPersonTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    
    self.images = [@[
                     @"",
                     @"",
                     @"",
                     @"",
                     @"",
                     @"",] mutableCopy];
    self.userBirthday = @"未填写";
    self.userName = @"未填写";
    self.userSexy = @"为选择";
    self.userGrade = @"普通";
    self.userSign = @"未填写";
    
}

- (NSArray *)cellConfigDict {
    
    return @[
             @{
                 @"icon":@"",
                 @"title":@"",
                 @"subTitle":@""
                 }
             
             ];
    
}

@end
