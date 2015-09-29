//
//  MMAddImageTableViewCell.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMAddImageTableViewCell.h"

@interface MMAddImageTableViewCell ()
@property (weak, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@end

@implementation MMAddImageTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIImageView *imageView in self.imageViews) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        [imageView addGestureRecognizer:gesture];
    }
    
}

- (void)configCellWithData:(id)data {
    
}

- (CGFloat)cellHeightWithData:(id)cellData {
    return kScreenWidth;
}

- (void)addImage:(UITapGestureRecognizer *)geture {

    UIImageView *imageView = (UIImageView *)geture.view;
    
    NSLog(@"%ld",(long)imageView.tag);
    
}

@end
