//
//  MMDetailUserMessageCell.m
//  My-Zone
//
//  Created by chiery on 15/11/5.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailUserMessageCell.h"
#import "MMFriendsInfoResult.h"

@interface MMDetailUserMessageCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepratorLineHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
@end

@implementation MMDetailUserMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sepratorLineHeight.constant = 0.5;
    [self setNeedsUpdateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return 64;
}

- (void)configCellWithData:(MMFriendsInfoResult *)data {
    if (!data) return;
    
    self.nameLabel.text = data.humanName;
    self.ageLabel.text = data.age;
    self.vipImage.image = [UIImage imageNamed:@"VIP5"];
    self.distanceLabel.text = @"暂无定位";
    self.timeLabel.text = @"暂无加入该功能";
}

@end
