//
//  MMImageDisplayVC.m
//  My-Zone
//
//  Created by chiery on 2016/10/19.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMImageDisplayVC.h"

@interface MMImageDisplayVC ()

@property (nonatomic) UIScrollView *scrollView;

@end

@implementation MMImageDisplayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
    [self layoutSubviews];
}

- (void)initViews {
    self.view.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.f];
}

- (void)layoutSubviews {
    [self.view addSubview:self.scrollView];
    [self addImageWithName:@"niconiconi" description:@"Animated GIF"];
    [self addImageWithName:@"wall-e" description:@"Animated WebP"];
    [self addImageWithName:@"pia" description:@"Animated PNG (APNG)"];
    [self addFrameImageWithText:@"Frame Animation"];
    [self addSpriteSheetImageWithText:@"Sprite Sheet Animation"];
}

- (void)addFrameImageWithText:(NSString *)text {
    
    NSString *basePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"EmoticonWeibo.bundle/com.sina.default"];
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_aini@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_baibai@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chanzui@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chijing@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_dahaqi@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_guzhang@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haha@2x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haixiu@3x.png"]];
    
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths oneFrameDuration:0.1 loopCount:0];
    [self addImage:image size:CGSizeZero description:text];
}

- (void)addSpriteSheetImageWithText:(NSString *)text {
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"ResourceTwitter.bundle/fav02l-sheet@2x.png"];
    UIImage *sheet = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path] scale:2];
    NSMutableArray *contentRects = [NSMutableArray new];
    NSMutableArray *durations = [NSMutableArray new];
    
    
    // 8 * 12 sprites in a single sheet image
    CGSize size = CGSizeMake(sheet.size.width / 8, sheet.size.height / 12);
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 8; i++) {
            CGRect rect;
            rect.size = size;
            rect.origin.x = sheet.size.width / 8 * i;
            rect.origin.y = sheet.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1 / 60.0)];
        }
    }
    YYSpriteSheetImage *sprite;
    sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:sheet
                                                     contentRects:contentRects
                                                   frameDurations:durations
                                                        loopCount:0];
    [self addImage:sprite size:size description:text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addImageWithName:(NSString *)name description:(NSString *)text {
    YYImage *image = [YYImage imageNamed:name];
    [self addImage:image size:CGSizeZero description:text];
}

- (void)addImage:(UIImage *)image size:(CGSize)size description:(NSString *)text {
    // 添加图片
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    if (size.width > 0 && size.height > 0) imageView.size = size;
    imageView.centerX = self.view.width/2;
    imageView.top = [(UIView *)[[self.scrollView subviews] lastObject] bottom] + 30;
    [self.scrollView addSubview:imageView];
    
    // 添加文案
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(0, 0, self.view.width, 20);
    label.top = imageView.bottom + 10;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [self.scrollView addSubview:label];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.width, label.bottom + 84)];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = self.view.bounds;
    }
    return _scrollView;
}

@end
