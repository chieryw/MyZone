//
//  MMSearchVC.m
//  My-Zone
//
//  Created by chiery on 15/10/19.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMSearchVC.h"
#import "MMPageScrollView.h"
#import "MMHomeVM.h"
#import "MMHomeResult.h"
#import "MMUserDetailVC.h"

@interface MMSearchVC ()<MMPageScrollViewDataSource,MMPageScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) MMPageScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editSortBarButton;
@property (nonatomic, strong) MMHomeVM *model;
@end

@implementation MMSearchVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
- (void)initModel {
    [self model];
    [self bindRAC];
}

- (void)bindRAC {
    @weakify(self)
    [RACObserve(self.model, showLoading) subscribeNext:^(id x) {
        @strongify(self)
        [self updateLoading];
    }];
    [RACObserve(self.model, reloadData) subscribeNext:^(id x) {
        @strongify(self);
        [self updateScrollView];
    }];
}

#pragma mark - 更新视图
- (void)updateLoading {
    if (self.model.showLoading) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)updateScrollView {
    [self.pageScrollView reloadData];
}

#pragma mark - 事件处理
- (IBAction)editSortType:(id)sender {
    [UIActionSheet showInView:self.view
                        title:@"选择当前展示类型"
                     delegate:self
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
                          tag:10
            otherButtonTitles:@[@"随机",@"最新",@"最赞"]];
}

#pragma mark - Property
- (MMPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[MMPageScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
        _pageScrollView.delegate = self;
        _pageScrollView.dataSource = self;
        [_pageScrollView setPadding:20];
        [_pageScrollView reloadData];
    }
    return _pageScrollView;
}

- (MMHomeVM *)model {
    if (!_model) {
        _model = [MMHomeVM new];
    }
    return _model;
}

#pragma mark -

- (NSInteger)numberOfPageInPageScrollView:(MMPageScrollView*)pageScrollView
{
    return self.array.count;
}

- (UIColor *)pageScrollView:(MMPageScrollView*)pageScrollView dataForRowAtIndex:(NSInteger)index
{
    return self.array[index];
}

- (void)pageScrollView:(MMPageScrollView*)pageScrollView didScrollToPageAtIndex:(NSInteger)index
{
    MMGuideInfoResult *guideInfo = self.model.homeResult.guideList[index];
    [self performSegueWithIdentifier:@"PushToUserDetailVC" sender:guideInfo];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        [self.editSortBarButton setTitle:buttonTitle];
        
        // 做接下来的处理
        [self.model fetchData:buttonIndex - 1];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    MMUserDetailVC *detailVC = segue.destinationViewController;
    // 给出数据模型
}


@end
