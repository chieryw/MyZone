//
//  MMAudioCorePlayer.h
//  My-Zone
//
//  Created by chiery on 2016/11/14.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAudioCorePlayer : NSObject

@property (nonatomic, assign) CGFloat volume;
@property (nonatomic, assign) CGFloat progress;

- (void)play;
- (void)pause;
- (void)stop;

@end
