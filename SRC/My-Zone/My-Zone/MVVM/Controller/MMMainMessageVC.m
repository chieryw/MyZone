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
#import "ChatViewController.h"

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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatViewController *chatC;
    if (indexPath.row %2 == 0) {
        chatC =[[ChatViewController alloc] initWithChatType:XMMessageChatGroup];
    }else{
        chatC = [[ChatViewController alloc] init];
    }
    chatC.chatterName = @"小新";
    chatC.chatterThumb = @"http://d.hiphotos.baidu.com/image/h%3D300/sign=5ea0f2a2a186c91717035439f93c70c6/a50f4bfbfbedab64c8255b9af136afc379311e10.jpg";
    chatC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatC animated:YES];
    chatC.hidesBottomBarWhenPushed = NO;
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
    self.cellDisplayingMenuOptions = cell;
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
    NSLog(@"delete");
}

- (void)cellDidSelectTop:(TLSwipeForOptionsCell *)cell {
    NSLog(@"Top");
}

- (void)cellDidSelectSelf:(id)mode {
    ChatViewController *chatC =[[ChatViewController alloc] init];
//    if (indexPath.row %2 == 0) {
//        chatC =[[ChatViewController alloc] initWithChatType:XMMessageChatGroup];
//    }else{
//        chatC =
//    }
    chatC.chatterName = @"小新";
    chatC.chatterThumb = @"http://d.hiphotos.baidu.com/image/h%3D300/sign=5ea0f2a2a186c91717035439f93c70c6/a50f4bfbfbedab64c8255b9af136afc379311e10.jpg";
    chatC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatC animated:YES];
    chatC.hidesBottomBarWhenPushed = NO;
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
