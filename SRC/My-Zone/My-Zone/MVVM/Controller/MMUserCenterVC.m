//
//  MMUserCenterVC.m
//  My-Zone
//
//  Created by chiery on 15/11/8.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMUserCenterVC.h"
#import "MMUserCenterDefaultCell.h"
#import "MMUserCenterHeaderView.h"
#import "MMDetailUserEvaluteCell.h"

@interface MMUserCenterVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableViewDataTree;

@end

@implementation MMUserCenterVC

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSubview];
    [self setupSubview];
}

- (void)initData {
    self.tableViewDataTree = @[
                               @[
                                   @[NSStringFromClass([MMUserCenterHeaderView class])],
                                   @[],
                                   ],
                               @[
                                   @[],
                                   @[NSStringFromClass([MMDetailUserEvaluteCell class])],
                                   ],
                               @[
                                   @[],
                                   @[NSStringFromClass([MMUserCenterDefaultCell class]),
                                     NSStringFromClass([MMUserCenterDefaultCell class]),
                                     NSStringFromClass([MMUserCenterDefaultCell class])
                                    ],
                                   ],
                               ];
}

- (void)initSubview {

}

- (void)setupSubview {
    [self registerTableViewSubview];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)registerTableViewSubview {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMDetailUserEvaluteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMDetailUserEvaluteCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMUserCenterDefaultCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMUserCenterDefaultCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMUserCenterHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"MMUserCenterHeaderView"];
    
//    for (NSArray *tempSection in self.tableViewDataTree) {
//        if (tempSection[0] && [tempSection[0] count] > 0) {
//            NSString *nibSectionName = tempSection[0][0];
//            [self.tableView registerNib:[UINib nibWithNibName:nibSectionName bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:nibSectionName];
//        }
//        if (tempSection[1] && [tempSection[1] count] > 0) {
//            for (NSString *tempCellNibName in tempSection[1]) {
//                [self.tableView registerNib:[UINib nibWithNibName:tempCellNibName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:tempCellNibName];
//            }
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.tableViewDataTree.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableViewDataTree[section]) {
        if (self.tableViewDataTree[section][1] && [self.tableViewDataTree[section][1] count] > 0) {
            return [self.tableViewDataTree[section][1] count];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewDataTree[indexPath.section]) {
        if (self.tableViewDataTree[indexPath.section][1] && [self.tableViewDataTree[indexPath.section][1] count] > 0) {
            return [NSClassFromString(self.tableViewDataTree[indexPath.section][1][indexPath.row]) cellHeightWithData:nil];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.tableViewDataTree[section]) {
        if (self.tableViewDataTree[section][0] && [self.tableViewDataTree[section][0] count] > 0) {
            return [NSClassFromString(self.tableViewDataTree[section][0][0]) viewHeightWithData:nil];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifierCell = @"";
    if (self.tableViewDataTree[indexPath.section]) {
        if (self.tableViewDataTree[indexPath.section][1] && [self.tableViewDataTree[indexPath.section][1] count] > 0) {
            identifierCell = self.tableViewDataTree[indexPath.section][1][indexPath.row];
        }
    }
    UITableViewCell<MMTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *identifierHerader = @"";
    if (self.tableViewDataTree[section]) {
        if (self.tableViewDataTree[section][0] && [self.tableViewDataTree[section][0] count] > 0) {
            identifierHerader = self.tableViewDataTree[section][0][0];
        }
    }
    MMUserCenterHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifierHerader];
    return view;
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"SettingVC" sender:nil];
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
