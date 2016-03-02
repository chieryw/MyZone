//
//  MMHomeVM.h
//  My-Zone
//
//  Created by chiery on 16/2/29.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMHomeResult.h"

typedef NS_ENUM(NSInteger, MMFetchDataType) {
    MMFetchDataTypeNewest = 0,
    MMFetchDataTypeBestest,
    MMFetchDataTypeRandom
};

@interface MMHomeVM : NSObject
@property (nonatomic, assign) BOOL showErrorView;
@property (nonatomic, assign) BOOL showLoading;
@property (nonatomic, assign) BOOL hasMore;             // 用于加载更多
@property (nonatomic, assign) BOOL reloadData;
@property (nonatomic, assign) MMFetchDataType fetchDataType;
@property (nonatomic, strong) MMHomeResult *homeResult;

//! 请求数据
- (void)fetchData;

//! 加载更多
- (void)loadMore;
@end
