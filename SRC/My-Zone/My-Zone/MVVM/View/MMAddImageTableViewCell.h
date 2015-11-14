//
//  MMAddImageTableViewCell.h
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTableViewCellProtocol.h"

@protocol MMAddImageCellDelegate <NSObject>

- (void)addImage:(UIImageView *)imageView;

@end

@interface MMAddImageTableViewCell : UITableViewCell<MMTableViewCellProtocol>

@property (nonatomic, weak) id<MMAddImageCellDelegate> delegate;

@end
