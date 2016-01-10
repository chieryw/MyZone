//
//  NSString+Addtion.h
//  My-Zone
//
//  Created by chiery on 15/10/21.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

// URLEncoding
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

//! 将侧当前string是否存在 是否有长度
- (BOOL)isStringSafe;

/**
 *  单行对应的字符串的size
 *
 *  @param font 字体的font
 *
 *  @return 该字符串在该font下的size
 */
- (CGSize)sizeWithFontCompatible:(UIFont *)font;

/**
 *  多行字符串的size
 *
 *  @param font          文字的font
 *  @param width         折行宽度
 *  @param lineBreakMode 折行类型
 *
 *  @return 多行文字的size
 */
- (CGSize)sizeWithFontCompatible:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
/**
 *  在一个固定rect中的给定font展现的size
 *
 *  @param font 文字的font
 *  @param size 约束的rect
 *
 *  @return 被约束后的文字展示需要的size
 */
- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  在一个固定rect中的给定font展现的size  多行文字
 *
 *  @param font          文字的font
 *  @param size          约束的rect
 *  @param lineBreakMode 文字换行类型
 *
 *  @return 被约束后的文字展示需要的size
 */
- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
