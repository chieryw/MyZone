//
//  MMFriendsZoneVC.m
//  My-Zone
//
//  Created by chiery on 15/11/12.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMFriendsZoneVC.h"
#import "MMFriendsCell.h"
#import "MMFriendsZoneVM.h"
#import "MMErrorView.h"
#import "MMFriendsInfo.h"

@interface MMFriendsZoneVC () <UITableViewDataSource,UITableViewDelegate,MMErrorViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MMFriendsZoneVM *model;
@property (nonatomic, strong) MMErrorView *errorView;
@end

@implementation MMFriendsZoneVC

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
    [self registerTableViewCell];
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
    [RACObserve(self.model, showErrorView) subscribeNext:^(id x) {
        @strongify(self);
        [self updateErrorView];
    }];
}

#pragma mark - 更新视图
- (void)updateLoading {
    if (self.model.showLoading) {
        MBProgressHUDShowInSelfWithAnimation
    }
    else {
        MBProgressHUDHideWithAnimation
    }
}

- (void)updateScrollView {
    [self.tableView reloadData];
}

- (void)updateErrorView {
    if (self.model.showErrorView) {
        self.errorView.hidden = NO;
        [self.view bringSubviewToFront:self.errorView];
    }
    else {
        self.errorView.hidden = YES;
    }
}

#pragma mark - Property
- (MMFriendsZoneVM *)model {
    if (!_model) {
        _model = [MMFriendsZoneVM new];
    }
    return _model;
}

- (MMErrorView *)errorView {
    if (!_errorView) {
        _errorView = [[MMErrorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
        _errorView.delegate = self;
    }
    return _errorView;
}


- (void)registerTableViewCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"MMFriendsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMFriendsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model.friendsList.visitorList) return self.model.friendsList.visitorList.count;
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 327;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMFriendsCell"];
    
    return cell;
}

#pragma mark - MMErrorViewDelegate
- (void)errorViewButtonPressed {
    [self.model fetchData];
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
