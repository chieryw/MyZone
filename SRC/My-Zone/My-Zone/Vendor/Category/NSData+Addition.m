//
//  NSData+Utility.m
//  QunariPhone
//
//  Created by chieryW on 14/11/29.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "NSData+Addition.h"
#import "zlib.h"

@implementation NSData (Addition)

// zlib解压缩函数
- (NSData *)deCompressZlibData:(NSUInteger)deDataSize
{
    if([self length] != 0)
    {
        // 分配解压空间
        NSMutableData *decompressedData = [NSMutableData dataWithLength:deDataSize];
        
        // 设置解压参数
        z_stream stream;
        stream.next_in = (Bytef *)[self bytes];
        stream.avail_in = (uInt)[self length];
        stream.total_in = 0;
        stream.next_out = (Bytef *)[decompressedData mutableBytes];
        stream.avail_out = (uint)[decompressedData length];
        stream.total_out = 0;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.opaque = Z_NULL;
        
        // 初始化
        if(inflateInit(&stream) == Z_OK)
        {
            // 解压缩
            int status = inflate(&stream, Z_SYNC_FLUSH);
            if(status == Z_STREAM_END)
            {
                // 清除
                if(inflateEnd(&stream) == Z_OK)
                {
                    return decompressedData;
                }
            }
        }
    }
    
    return nil;
}

// Range校验
- (BOOL)isRangeValidFromIndex:(NSInteger)index withSize:(NSInteger)rangeSize
{
    NSUInteger dataLength = [self length];
    
    if ((dataLength - index) < rangeSize)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
