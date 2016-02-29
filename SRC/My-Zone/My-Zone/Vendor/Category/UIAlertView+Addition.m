//
//  UIAlertView+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/21.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "UIAlertView+Addition.h"

@implementation UIAlertView (Addition)

+ (void)networkError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"网络错误!"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

+ (void)tipTitle:(NSString *)title buttonName:(NSString *)buttonName {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(title?:@"")
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:buttonName, nil];
    [alertView show];
    
}

+ (void)tipMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

+ (void)showTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitle, nil];
    [alertView show];
}

@end
