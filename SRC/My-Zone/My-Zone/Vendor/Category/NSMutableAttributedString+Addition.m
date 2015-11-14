//
//  NSMutableString+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "NSMutableAttributedString+Addition.h"

@implementation NSMutableAttributedString (Addition)


- (void)setTextForeColor:(UIColor *)color{
    [self setTextForeColor:color range:NSMakeRange(0,[self length])];
}

- (void)setTextForeColor:(UIColor *)color range:(NSRange)range{
    // NSForegroundColorAttributeName
    [self removeAttribute:NSForegroundColorAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)setFontFore:(UIFont *)font{
    [self setFontFore:font range:NSMakeRange(0,[self length])];
}

- (void)setFontFore:(UIFont *)font range:(NSRange)range{
    // NSFontAttributeName
    [self removeAttribute:NSFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)appendAttributedForeString:(NSString *)string
                          withFont:(UIFont *)font
                      andTextColor:(UIColor *)color{
    NSInteger rangeRight = 0;
    NSInteger rangeLeft = 0;
    // 变色范围左值
    rangeLeft = [self length];
    
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
    
    // 变色范围右值
    rangeRight = [self length];
    [self setTextForeColor:color range:NSMakeRange(rangeLeft, rangeRight-rangeLeft)];
    [self setFontFore:font range:NSMakeRange(rangeLeft, rangeRight-rangeLeft)];
}

-(void)setTextForeAlignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)lineBreakMode{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.alignment = alignment;
    
    //NSDictionary *attributeDic = @{NSParagraphStyleAttributeName:paraStyle};
    [self removeAttribute:NSParagraphStyleAttributeName range:NSMakeRange(0,[self length])];
    [self addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0,[self length])];
}

-(CGSize)sizeForeConstrainedToSize:(CGSize)maxSize{
    CGRect frame = [self boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    CGSize resultSize = frame.size;
    return resultSize;
}

@end
