//
//  MMNewFriendsListResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"
#import "MMNewFriendsInfo.h"

@interface MMNewFriendsListResult : MMSearchNetResult
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSArray <MMNewFriendsInfo> *visitorList;
@end
