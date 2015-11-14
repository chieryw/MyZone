//
//  MMAppSetting.h
//  My-Zone
//
//  Created by chiery on 15/9/19.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAppSetting : NSObject

+ (instancetype)getInstance;

// 配置首页宣传页显示参数
- (void)configureIntroView;

@end
