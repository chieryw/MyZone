//
//  MMDetailUserEvaluteCell.m
//  My-Zone
//
//  Created by chiery on 15/11/6.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailUserEvaluteCell.h"

@interface MMDetailUserEvaluteCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepratorLineHeight;

@end

@implementation MMDetailUserEvaluteCell

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
    return 50;
}

- (void)configCellWithData:(id)data {
    
}

@end
