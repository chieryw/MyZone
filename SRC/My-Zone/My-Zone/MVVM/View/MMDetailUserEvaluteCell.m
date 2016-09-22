//
//  MMDetailUserEvaluteCell.m
//  My-Zone
//
//  Created by chiery on 15/11/6.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailUserEvaluteCell.h"
#import "MMFriendsInfoResult.h"
#import "MMUserDetailVM.h"

@interface MMDetailUserEvaluteCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepratorLineHeight;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UILabel *oohNoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodEvaluteConstraint;
@property (nonatomic, strong) MMUserDetailVM *superModel;

@end

@implementation MMDetailUserEvaluteCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
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

- (void)configCellWithData:(MMFriendsInfoResult *)data {
    if (!data) return;
    
    self.goodLabel.text = data.praiseNum;
    self.oohNoLabel.text = data.treadNum;
    
}

- (void)linkSuperModel:(MMUserDetailVM *)model {
    if (!model) return;
    self.superModel = model;
}

- (IBAction)good:(id)sender {
    self.superModel.goodAction = YES;
}

- (IBAction)oohNO:(id)sender {
    self.superModel.oohNoActionClick = YES;
}
@end
