//
//  MMPersonMessageTVC.m
//  My-Zone
//
//  Created by chiery on 15/9/29.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonMessageTVC.h"
#import "MMPersonTableViewModel.h"

@interface MMPersonMessageTVC ()
@property (weak, nonatomic) IBOutlet UIView *backgroundMaskView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation MMPersonMessageTVC

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.backgroundMaskView.backgroundColor = selected?[UIColor MMGrayBackgroundColor]:[UIColor whiteColor];
    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return 50;
}

- (void)configCellWithData:(id)data {
    
    if ([data isKindOfClass:[MMPersonMessageCellModel class]]) {
        
        MMPersonMessageCellModel *model = (MMPersonMessageCellModel *)data;
        
        self.iconImageView.image = [UIImage imageNamed:model.icon];
        self.titleLabel.text = model.title;
        self.subTitleLabel.text = ((model.subTitle.length>0)?model.subTitle:model.defaultSubTitle);
    }
    
}

+ (instancetype)create {

    MMPersonMessageTVC *personMessageCell = [[[NSBundle mainBundle] loadNibNamed:@"MMPersonMessageTVC"
                                                                          owner:self
                                                                        options:nil] firstObject];
    return personMessageCell;
    
}

@end
