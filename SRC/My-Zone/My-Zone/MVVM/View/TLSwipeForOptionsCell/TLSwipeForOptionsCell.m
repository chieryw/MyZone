//
//  TLSwipeForOptionsCell.m
//  TLSwipeForOptionsCell
//
//  Created by Ash Furrow on 2013-07-29.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLSwipeForOptionsCell.h"

NSString *const TLSwipeForOptionsCellShouldHideMenuNotification = @"TLSwipeForOptionsCellShouldHideMenuNotification";

#define kCatchWidth 240.0f

@interface TLSwipeForOptionsCell () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *scrollViewContentView;//The cell content (like the label) goes in this view.
@property (nonatomic, strong) UIView       *scrollViewButtonView;//Contains our two buttons
@property (nonatomic, strong) UILabel      *scrollViewLabel;
@property (nonatomic, strong) UIImageView  *headerImageView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UILabel      *subTitleLabel;
@property (nonatomic, strong) UILabel      *timeLabel;
@property (nonatomic, assign) BOOL         isShowingMenu;

@end

@implementation TLSwipeForOptionsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSubview];
    [self setupSubview];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self initSubview];
        [self setupSubview];
	}
	return self;
}



- (void)initSubview {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollViewButtonView];
    [self.scrollView addSubview:self.scrollViewContentView];
    [self.scrollViewContentView addSubview:self.headerImageView];
    [self.scrollViewContentView addSubview:self.titleLabel];
    [self.scrollViewContentView addSubview:self.subTitleLabel];
    [self.scrollViewContentView addSubview:self.timeLabel];
}

- (void)setupSubview {
    self.isShowingMenu = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuOptions) name:TLSwipeForOptionsCellShouldHideMenuNotification object:nil];
}

- (void)hideMenuOptions {
	[self.scrollView setContentOffset:CGPointZero animated:YES];
}

+ (CGFloat)cellHeightWithData:(id)cellData {
    return 65;
}

- (void)configCellWithData:(id)data {
    
}

#pragma mark - Private Methods 

- (void)userPressedDeleteButton:(id)sender {
	[self.delegate cellDidSelectDelete:self];
	[self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)userPressedMoreButton:(id)sender {
	[self.delegate cellDidSelectTop:self];
}

#pragma mark - Overridden Methods
- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + kCatchWidth, 65);
	self.scrollView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 65);
	self.scrollViewButtonView.frame = CGRectMake(CGRectGetWidth(self.bounds) - kCatchWidth, 0.0f, kCatchWidth, 65);
	self.scrollViewContentView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 65);
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self.scrollView setContentOffset:CGPointZero animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	self.scrollView.scrollEnabled = !self.editing;
    self.scrollViewButtonView.hidden = editing;
}

- (UILabel *)textLabel {
	return self.scrollViewLabel;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	if (scrollView.contentOffset.x > kCatchWidth) {
		targetContentOffset->x = kCatchWidth;
	} else {
		*targetContentOffset = CGPointZero;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[scrollView setContentOffset:CGPointZero animated:YES];
		});
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (scrollView.contentOffset.x < 0.0f) {
		scrollView.contentOffset = CGPointZero;
	}
	
	self.scrollViewButtonView.frame = CGRectMake(scrollView.contentOffset.x + (CGRectGetWidth(self.bounds) - kCatchWidth), 0.0f, kCatchWidth, 65);
	
	if (scrollView.contentOffset.x >= kCatchWidth) {
		if (!self.isShowingMenu) {
			self.isShowingMenu = YES;
			[self.delegate cell:self didShowMenu:self.isShowingMenu];
		}
	} else if (scrollView.contentOffset.x == 0.0f) {
		if (self.isShowingMenu) {
			self.isShowingMenu = NO;
			[self.delegate cell:self didShowMenu:self.isShowingMenu];
		}
	}
}

#pragma mark - propert init 
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 65)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) + kCatchWidth, 65);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)scrollViewContentView {
    if (!_scrollViewContentView) {
        _scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 65)];
        _scrollViewContentView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollViewContentView;
}

- (UIView *)scrollViewButtonView {
    if (!_scrollViewButtonView) {
        _scrollViewButtonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - kCatchWidth, 0.0f, kCatchWidth, 65)];
        
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.backgroundColor = [UIColor MMGrayBackgroundColor];
        topButton.frame = CGRectMake(0.0f, 0.0f, kCatchWidth / 2.0f, 65);
        [topButton setImage:[UIImage imageNamed:@"CancelTopIcon"] forState:UIControlStateNormal];
        [topButton setTitle:@" 取消置顶" forState:UIControlStateNormal];
        [topButton setTitleColor:[UIColor MMTextColor] forState:UIControlStateNormal];
        [topButton addTarget:self action:@selector(userPressedMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollViewButtonView addSubview:topButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.backgroundColor = [UIColor orangeColor];
        deleteButton.frame = CGRectMake(kCatchWidth / 2.0f, 0.0f, kCatchWidth / 2.0f, 65);
        [deleteButton setImage:[UIImage imageNamed:@"DeleteIcon"] forState:UIControlStateNormal];
        [deleteButton setTitle:@" 删除聊天" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(userPressedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollViewButtonView addSubview:deleteButton];
    }
    return _scrollViewButtonView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        CGSize imageSize = CGSizeMake(36, 36);
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,
                                                                         (65-36)/2,
                                                                         imageSize.width,
                                                                         imageSize.height)];
        [_headerImageView setBackgroundColor:[UIColor redColor]];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + 36 + 10,
                                                                (65-36)/2,
                                                                200,
                                                                18)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor MMTextColor];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + 36 + 10,
                                                                   (65-36)/2 + 22,
                                                                   200,
                                                                   14)];
        _subTitleLabel.font = [UIFont MMTextFont12];
        _subTitleLabel.textColor = [UIColor MMTextTipColor];
    }
    return _subTitleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 15 - 80,
                                                               15,
                                                               80,
                                                               14)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor MMTextTipColor];
        _timeLabel.font = [UIFont MMTextFont12];
    }
    return _timeLabel;
}

@end