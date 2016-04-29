//
//  MMInviteGuideResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@interface MMInviteGuideMessageResult : MMSearchNetResult
@property (nonatomic, strong) NSNumber *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *fileID;
@end

@interface MMInviteGuideResult : MMSearchNetResult
@property (nonatomic, strong) MMInviteGuideMessageResult *resultInfo;

@end
