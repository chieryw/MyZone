//
//  UIAlertView+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/21.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "UIAlertView+Addition.h"

@implementation UIAlertView (Addition)

+ (void)tipTitle:(NSString *)title buttonName:(NSString *)buttonName {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(title?:@"")
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:buttonName, nil];
    [alertView show];
    
}


@end
