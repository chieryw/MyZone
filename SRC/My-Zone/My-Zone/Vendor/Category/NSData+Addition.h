//
//  NSData+Utility.h
//  QunariPhone
//
//  Created by chieryW on 14/11/29.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Addition)


// zlib解压缩函数
- (NSData *)deCompressZlibData:(NSUInteger)deDataSize;

// Range校验
- (BOOL)isRangeValidFromIndex:(NSInteger)index withSize:(NSInteger)rangeSize;

@end
