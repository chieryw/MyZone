//
//  NSMutableString+Addition.h
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Addition)

-(void)setTextForeColor:(UIColor*)color;
-(void)setTextForeColor:(UIColor*)color range:(NSRange)range;

- (void)setFontFore:(UIFont *)font;
- (void)setFontFore:(UIFont *)font range:(NSRange)range;

-(void)appendAttributedForeString:(NSString *)string
                         withFont:(UIFont *)font
                     andTextColor:(UIColor *)color;

-(void)setTextForeAlignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode;

-(CGSize)sizeForeConstrainedToSize:(CGSize)maxSize;

@end
