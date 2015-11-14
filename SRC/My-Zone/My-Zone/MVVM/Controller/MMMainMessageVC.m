//
//  MMMainMessageVC.m
//  My-Zone
//
//  Created by chiery on 15/11/11.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMMainMessageVC.h"
#import "TLOverlayView.h"
#import "TLSwipeForOptionsCell.h"

@interface MMMainMessageVC ()<UITableViewDataSource,UITableViewDelegate,TLSwipeForOptionsCellDelegate,TLOverlayViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) UITableViewCell *cellDisplayingMenuOptions;
@property (nonatomic, strong) TLOverlayView *overlayView;

@end

@implementation MMMainMessageVC
- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
    [self setupSubview];
}

- (void)initSubview {

}

- (void)setupSubview {
    [self registerTableViewCellClass];
}

- (void)registerTableViewCellClass {
    [self.tableView registerClass:[TLSwipeForOptionsCell class] forCellReuseIdentifier:@"MMMessageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLSwipeForOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMMessageCell"];
    cell.delegate = self;
    return cell;
}

#pragma UIScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellShouldHideMenuNotification object:scrollView];
}

#pragma mark - TLOverlayViewDelegate Methods

- (UIView *)overlayView:(TLOverlayView *)view didHitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL shouldInterceptTouches = YES;
    
    CGPoint location = [self.view convertPoint:point fromView:view];
    CGRect rect = [self.view convertRect:self.cellDisplayingMenuOptions.frame toView:self.view];
    
    shouldInterceptTouches = CGRectContainsPoint(rect, location);
    if (!shouldInterceptTouches)
        [[NSNotificationCenter defaultCenter] postNotificationName:TLSwipeForOptionsCellShouldHideMenuNotification object:self.tableView];
    
    return shouldInterceptTouches?[self.cellDisplayingMenuOptions hitTest:point withEvent:event]:view;
}
#pragma mark - TLSwipeForOptionsCellDelegate Methods

- (void)cell:(TLSwipeForOptionsCell *)cell didShowMenu:(BOOL)isShowingMenu {
    [self.tableView setScrollEnabled:!isShowingMenu];
    if (isShowingMenu) {
        if (!self.overlayView) {
            self.overlayView = [[TLOverlayView alloc] initWithFrame:self.view.bounds];
            [self.overlayView setDelegate:self];
        }
        
        [self.overlayView setFrame:self.view.bounds];
        [self.view addSubview:self.overlayView];
        
        for (id subview in [self.tableView subviews]) {
            if (![subview isEqual:cell] && [subview isKindOfClass:[TLSwipeForOptionsCell class]])
                [subview setUserInteractionEnabled:NO];
        }
    } else {
        [self.overlayView removeFromSuperview];
        
        for (id subview in [self.tableView subviews]) {
            if (![subview isEqual:cell] && [subview isKindOfClass:[TLSwipeForOptionsCell class]])
                [subview setUserInteractionEnabled:YES];
        }
    }
}

- (void)cellDidSelectDelete:(TLSwipeForOptionsCell *)cell {
    
}

- (void)cellDidSelectTop:(TLSwipeForOptionsCell *)cell {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
