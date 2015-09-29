//
//  MMAddImageTableViewCell.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMAddImageTableViewCell.h"
#import "MMPersonTableViewModel.h"

@interface MMAddImageTableViewCell ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

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
    if ([data isKindOfClass:[MMAddImageCellModel class]]) {
        MMAddImageCellModel *model = (MMAddImageCellModel *)data;
        
        for (NSInteger i = 0; i < model.images.count; i ++) {
            UIImageView *imageView = self.imageViews[i];
            imageView.image = [UIImage imageNamed:model.images[i]];
        }
    }
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return kScreenWidth;
}

- (void)addImage:(UITapGestureRecognizer *)geture {

    UIImageView *imageView = (UIImageView *)geture.view;
    
    NSLog(@"%ld",(long)imageView.tag);
    
}

+ (instancetype)create {

    MMAddImageTableViewCell *addImageCell = [[[NSBundle mainBundle] loadNibNamed:@"MMAddImageTableViewCell"
                                                                           owner:self
                                                                         options:nil] firstObject];
    return addImageCell;
    
}

@end
