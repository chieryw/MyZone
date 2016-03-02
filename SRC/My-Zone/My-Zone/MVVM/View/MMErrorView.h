//
//  MMErrorView.h
//  My-Zone
//
//  Created by chiery on 16/3/1.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

//! 点击errorView中button
@protocol MMErrorViewDelegate <NSObject>
- (void)errorViewButtonPressed;
@end


@interface MMErrorView : UIView

//! 按钮点击代理回调
@property (nonatomic, weak) id<MMErrorViewDelegate>delegate;

/**
 *  更新网络回调
 *
 *  @param message     网络错误信息
 *  @param buttonTitle 按钮文案
 */
- (void)updateMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle;
@end
