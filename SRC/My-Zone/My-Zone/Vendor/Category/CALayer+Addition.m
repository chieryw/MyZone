//
//  CALayer+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/19.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

- (void)setXibColor:(UIColor *)xibColor {

    self.borderColor = xibColor.CGColor;
    
}

- (UIColor *)xibColor {

    return [UIColor colorWithCGColor:self.borderColor];
    
}

@end
