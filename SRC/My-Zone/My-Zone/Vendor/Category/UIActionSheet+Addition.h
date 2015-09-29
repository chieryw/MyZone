//
//  UIActionSheet+Addition.h
//  My-Zone
//
//  Created by chiery on 15/9/29.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Addition)

+ (nullable instancetype)showActionSheet:(nullable NSString *)title
                                delegate:(nullable id<UIActionSheetDelegate>)delegate
                       cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                  destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                     tag:(NSInteger)tag
                              showInView:(nullable UIView *)view
                       otherButtonTitles:(nullable NSArray *)otherButtonTitles;

@end
