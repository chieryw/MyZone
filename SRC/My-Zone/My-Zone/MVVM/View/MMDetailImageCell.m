//
//  MMDetailImageCell.m
//  My-Zone
//
//  Created by chiery on 15/10/25.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDetailImageCell.h"
#import "MMFriendsInfoResult.h"

@interface MMDetailImageCell ()<UIAlertViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *seeAllPhotos;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@end

@implementation MMDetailImageCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)sureButton:(id)sender {
    [UIAlertView showTitle:@"福利来了"
                   message:@"版本测试期间你可以尽情的测试了"
                  delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil];
}

- (void)configCellWithData:(MMFriendsInfoResult *)data {
    if (!data) return;
    [self configScrollViewData:data];
}

- (void)configScrollViewData:(MMFriendsInfoResult *)data {
    if (!data) return;
    
    CGRect rect = self.scrollView.bounds;
    self.scrollView.contentSize = CGSizeMake(rect.size.width * data.images.count, rect.size.height);
    
    __weak typeof(self) weakSelf = self;
    [data.images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * rect.size.width, 0, rect.size.width, rect.size.height)];
        imageView.image = image;
        [strongSelf.scrollView addSubview:imageView];
    }];
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return kScreenWidth;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.maskView.hidden = YES;
}

@end
