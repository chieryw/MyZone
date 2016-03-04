//
//  MMDetailUserDescriptionCell.m
//  My-Zone
//
//  Created by chiery on 15/11/6.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailUserDescriptionCell.h"
#import "MMFriendsInfoResult.h"

@interface MMDetailUserDescriptionCell ()
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@end

@implementation MMDetailUserDescriptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return 44;
}

- (void)configCellWithData:(MMFriendsInfoResult *)data {
    if (!data) return;
    
    self.signLabel.text = data.signName;
}

@end
