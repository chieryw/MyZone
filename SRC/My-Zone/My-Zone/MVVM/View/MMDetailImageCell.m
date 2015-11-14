//
//  MMDetailImageCell.m
//  My-Zone
//
//  Created by chiery on 15/10/25.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailImageCell.h"

@interface MMDetailImageCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *seeAllPhotos;


@end

@implementation MMDetailImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithData:(id)data {
    
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return kScreenWidth;
}

@end
