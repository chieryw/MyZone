//
//  QWSearchNetDelgt.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMSearchNetDelgt.h"
#import "MMSearchNetStatus.h"

@implementation MMSearchNetDelgt

// 数据接收结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 解析数据
    @autoreleasepool
    {
        BOOL result = [MMSearchNetDelgt parseSearchResult:self.receivedData toResult:_searchResult];
        if(!result)
        {
            _searchResult = nil;
        }
    }
    
    if (self.resultBlock) {
        self.resultBlock(_searchResult.bstatus,_searchResult);
    }
    
    [super URLSession:session task:task didCompleteWithError:error];
}

// 解析请求结果
+ (BOOL)parseSearchResult:(NSData *)resultData
                 toResult:(MMSearchNetResult *)searchNetResult
{
    if(resultData && resultData.length > 0)
    {
        NSError *error;
        NSDictionary *tempDictionary = [NSJSONSerialization JSONObjectWithData:resultData
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&error];
        
        if (!error && tempDictionary) {
            if(searchNetResult != nil)
            {
                [searchNetResult parseAllNetResult:tempDictionary];
                return YES;
            }
        }
    }
    
    return NO;
}
@end
