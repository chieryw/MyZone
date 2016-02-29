//
//  UIAlertView+Addition.h
//  My-Zone
//
//  Created by chiery on 15/9/21.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Addition)

//! 没有网络时候的警告
+ (void)networkError;

/**
 *  title  提示
 *
 *  @param title      title文案
 *  @param buttonName 按钮的名字
 */
+ (void)tipTitle:(NSString *)title buttonName:(NSString *)buttonName;

/**
 *  message 提示
 *
 *  @param message 信息提示
 */
+ (void)tipMessage:(NSString *)message;

/**
 *  alertView simple
 *
 *  @param title             title
 *  @param message           message
 *  @param delegate          delegate
 *  @param cancelButtonTitle cancelButtonTitle
 *  @param otherButtonTitles otherButtonTitle
 */
+ (void)showTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle;

@end
