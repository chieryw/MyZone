//
//  MMDetailUserMessageCell.m
//  My-Zone
//
//  Created by chiery on 15/11/5.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailUserMessageCell.h"

@interface MMDetailUserMessageCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepratorLineHeight;

@end

@implementation MMDetailUserMessageCell

- (void)awakeFromNib {
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

- (void)configCellWithData:(id)data {

}

@end
