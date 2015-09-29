//
//  UIActionSheet+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/29.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "UIActionSheet+Addition.h"

@implementation UIActionSheet (Addition)

+ (nullable instancetype)showActionSheet:(NSString *)title
                                delegate:(id<UIActionSheetDelegate>)delegate
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                  destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                     tag:(NSInteger)tag
                              showInView:(UIView *)view
                       otherButtonTitles:(NSArray *)otherButtonTitles {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:delegate
                                                    cancelButtonTitle:cancelButtonTitle
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil, nil];
    if (otherButtonTitles && otherButtonTitles.count > 0) {
        for (NSString *buttonTitle in otherButtonTitles) {
            [actionSheet addButtonWithTitle:buttonTitle];
        }
    }
    actionSheet.tag = tag;
    [actionSheet showInView:view];
    return actionSheet;
}

@end
