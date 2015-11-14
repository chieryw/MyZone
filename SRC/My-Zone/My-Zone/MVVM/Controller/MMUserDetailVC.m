//
//  MMUserDetailVC.m
//  My-Zone
//
//  Created by chiery on 15/10/25.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMUserDetailVC.h"
#import "MMDetailImageCell.h"
#import "MMDetailUserMessageCell.h"
#import "MMDetailUserEvaluteCell.h"
#import "MMDetailUserDescriptionCell.h"

@interface MMUserDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableViewCellTree;

@end

@implementation MMUserDetailVC

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSubview];
    [self setupSubview];
}

- (void)initData {
    self.tableViewCellTree = @[
                               @[NSStringFromClass([MMDetailImageCell class])],
                               @[NSStringFromClass([MMDetailUserMessageCell class])],
                               @[NSStringFromClass([MMDetailUserEvaluteCell class])],
                               @[NSStringFromClass([MMDetailUserDescriptionCell class])],
                               ];
}

- (void)initSubview {

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton.layer setCornerRadius:4];
    [chatButton setFrame:CGRectMake(20, 60, CGRectGetWidth(self.view.bounds) - 40, 40)];
    [chatButton setBackgroundColor:[UIColor MMBlueColor]];
    [chatButton setTitle:@"开始聊天" forState:UIControlStateNormal];
    [chatButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [chatButton setTintColor:[UIColor whiteColor]];
    [chatButton addTarget:self action:@selector(startChat) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:chatButton];
    self.tableView.tableFooterView = footerView;
}

- (void)setupSubview {
    [self registerTableViewCell];
    self.title = @"导游详情";
}

- (void)registerTableViewCell {
    for (NSArray *cellData in self.tableViewCellTree) {
        [self.tableView registerNib:[UINib nibWithNibName:cellData[0]
                                                   bundle:[NSBundle mainBundle]]
             forCellReuseIdentifier:cellData[0]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 事件处理
- (void)startChat {
    NSLog(@"hello");
}


#pragma mark - UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewCellTree.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.tableViewCellTree[indexPath.row][0];
    return [NSClassFromString(className) cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<MMTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:self.tableViewCellTree[indexPath.row][0]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"UserEvalute" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
