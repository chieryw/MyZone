//
//  MMUserCenterHeaderView.h
//  My-Zone
//
//  Created by chiery on 15/11/8.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMUserCenterHeaderView : UITableViewHeaderFooterView

+ (CGFloat)viewHeightWithData:(id)data;
- (void)configureData:(id)data;

@end
