//
//  MMUserCenterDefaultCell.m
//  My-Zone
//
//  Created by chiery on 15/11/8.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMUserCenterDefaultCell.h"

@implementation MMUserCenterDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return 44;
}

- (void)configCellWithData:(id)data {
    
}

@end
