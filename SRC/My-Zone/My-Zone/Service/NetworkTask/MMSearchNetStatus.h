//
//  MMSearchNetStatus.h
//  My-Zone
//
//  Created by chiery on 2016/9/22.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMSearchNetStatus : NSObject

@property (nonatomic, strong) NSNumber *code;            // 返回代码
@property (nonatomic, strong) NSString *des;             // 返回描述
@property (nonatomic, strong) NSString *info;            // 返回信息

@end
