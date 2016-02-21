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

@end
