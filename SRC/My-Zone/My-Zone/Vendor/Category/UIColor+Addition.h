//
//  UIColor+Addition.h
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(__r, __g, __b) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:1]
#define RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:__a]
#define HEX(__color) [UIColor colorWithHEX:(__color)]

@interface UIColor (Addition)

+ (UIColor *)MMTextColor;

/**
 *  文字颜色主系列2  浅黑色
 *
 *  @return 浅黑色
 */
+ (UIColor *)MMTextTipColor;

/**
 *  蓝色主系列
 *
 *  @return 主题蓝色
 */
+ (UIColor *)MMBlueColor;

/**
 *  浅灰色背景色
 *
 *  @return 浅灰色背景色
 */
+ (UIColor *)MMGrayBackgroundColor;

@end
