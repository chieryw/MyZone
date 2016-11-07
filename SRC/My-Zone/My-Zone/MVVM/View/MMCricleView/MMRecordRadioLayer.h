//
//  MMRecordRadioLayer.h
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MMRecordRadioLayer : CALayer


/**
 声音大小
 */
@property (nonatomic, assign) CGFloat volume;


/**
 开始动画
 */
- (void)startAnimation;


/**
 结束动画
 */
- (void)stopAnimation;

@end
