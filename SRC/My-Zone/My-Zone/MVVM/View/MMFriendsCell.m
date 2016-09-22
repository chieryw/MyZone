//
//  MMFriendsCell.m
//  My-Zone
//
//  Created by chiery on 15/11/12.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMFriendsCell.h"
#import "MMFriendsInfo.h"

@interface MMFriendsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *usetHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end

@implementation MMFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithData:(MMFriendsInfo *)data {
    // 在这里配置数据
}

@end
