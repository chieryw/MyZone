//
//  MMTableViewCellProtocol.h
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMTableViewCellProtocol <NSObject>

- (void) configCellWithData:(id) data;

@optional
+ (CGFloat) cellHeightWithData:(id) cellData;

+ (id)create;

@end
