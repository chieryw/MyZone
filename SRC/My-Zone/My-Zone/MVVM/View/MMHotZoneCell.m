//
//  MMHotZoneCell.m
//  My-Zone
//
//  Created by chiery on 15/10/21.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMHotZoneCell.h"
#import "MMHotZoneCellModel.h"

@interface MMHotZoneCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speraLineHeight;

@end

@implementation MMHotZoneCell

- (void)awakeFromNib {
    // Initialization code
    [self configureSelf];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureSelf {
    
    // 切换分割线的高度
    self.speraLineHeight.constant = 0.5;
    [self setNeedsUpdateConstraints];
    
}

- (void)configCellWithData:(id)data {
    
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    
//    CGFloat height = 0;
//    if ([cellData isKindOfClass:[MMHotZoneCellModel class]]) {
        MMHotZoneCellModel *model = (MMHotZoneCellModel *)cellData;
        //  计算多行文字的高度
        NSString *tempString = @"来自中国青年旅社，从事导游工作4年半，中青年控股有限公司美加部，个人特长接收了7年专业游泳训练。";
        CGSize size = [tempString sizeWithFontCompatible:[UIFont systemFontOfSize:12]
                                  forWidth:CGRectGetWidth([[UIScreen mainScreen] bounds]) - 36
                             lineBreakMode:NSLineBreakByWordWrapping];
        
        return 8 + 300 + 8 + 18 + 5 + 14 + 6 + 1 + 8 + size.height + 8 + 8;
//    }
    
    return 0;
    
}

@end
