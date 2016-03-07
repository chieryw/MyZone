//
//  MMFriendsZoneVM.h
//  My-Zone
//
//  Created by chiery on 16/3/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMNewFriendsListResult.h"

@interface MMFriendsZoneVM : NSObject
@property (nonatomic, assign) BOOL showErrorView;
@property (nonatomic, assign) BOOL showLoading;
@property (nonatomic, assign) BOOL hasMore;             // 用于加载更多
@property (nonatomic, assign) BOOL reloadData;
@property (nonatomic, strong) MMNewFriendsListResult *friendsList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger currentPageCount;

//! 请求数据
- (void)fetchData;

//! 加载更多
- (void)loadMore;

@end
