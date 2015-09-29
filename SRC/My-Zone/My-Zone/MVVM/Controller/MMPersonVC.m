//
//  MMPersonVC.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonVC.h"
#import "MMPersonTableViewModel.h"
#import "MMTableViewCellProtocol.h"
#import "MMAddImageTableViewCell.h"
#import "MMPersonMessageTVC.h"
#import <MobileCoreServices/UTCoreTypes.h>

typedef NS_ENUM(NSInteger, MMActionSheetType) {
    MMActionSheetTypeSexy,
    MMActionSheetTypePhoto,
};

@interface MMPersonVC ()<UITableViewDataSource,UITableViewDelegate,MMAddImageCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MMPersonTableViewModel *tableViewModel;
@property (nonatomic, strong) NSArray *tableDataSource;

@end

@implementation MMPersonVC

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
    
    self.navigationController.navigationBarHidden = NO;
    
    [self configTableView];
}

#pragma mark - 事件处理函数
- (void)editUserName {
    
}

- (void)chooseSexy {
    [UIActionSheet showActionSheet:nil
                          delegate:self
                 cancelButtonTitle:@"取消"
            destructiveButtonTitle:nil
                               tag:MMActionSheetTypeSexy
                        showInView:self.view
                 otherButtonTitles:@[@"男",@"女"]];
}

- (void)chooseBirthday {
    
}

- (void)editSign {

}

- (void)takePhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)choosePhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - 辅助函数
- (void)configTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self registerTableViewClass];
}

// 注册所有的tableCell
- (void)registerTableViewClass {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMAddImageTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"MMAddImageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMPersonMessageTVC" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"MMPersonMessageTVC"];
}

- (void)savaImage:(UIImage *)image {
    
}

#pragma mark - init
- (MMPersonTableViewModel *)tableViewModel {
    if (!_tableViewModel) {
        _tableViewModel = [[MMPersonTableViewModel alloc] init];
    }
    return _tableViewModel;
}

- (NSArray *)tableDataSource {
    if (!_tableDataSource) {
        _tableDataSource = @[
                             self.tableViewModel.addImageCellModel,
                             self.tableViewModel.userNameCellModel,
                             self.tableViewModel.userSexyCellModel,
                             self.tableViewModel.userBirthdayCellModel,
                             self.tableViewModel.userSignCellModel,
                             self.tableViewModel.userGradeCellModel
                             ];
    }
    return _tableDataSource;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 0;
    
    id object = self.tableDataSource[indexPath.row];
    if ([object isKindOfClass:[MMAddImageCellModel class]]) {
       height = [MMAddImageTableViewCell cellHeightWithData:nil];
    }
    else {
       height = [MMPersonMessageTVC cellHeightWithData:nil];
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = self.tableDataSource[indexPath.row];
    NSString *identifierCell = @"";
    if ([object isKindOfClass:[MMAddImageCellModel class]]) {
        identifierCell = NSStringFromClass([MMAddImageTableViewCell class]);
    }
    else {
        identifierCell = NSStringFromClass([MMPersonMessageTVC class]);
    }
    
    UITableViewCell<MMTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    [cell configCellWithData:self.tableDataSource[indexPath.row]];
    
    // 添加代理
    if ([cell isKindOfClass:[MMAddImageTableViewCell class]]) {
        [(MMAddImageTableViewCell *)cell setDelegate:self];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        // 不做处理
    }
    else if (indexPath.row == 1) {
        [self editUserName];
    }
    else if (indexPath.row == 2) {
        [self chooseSexy];
    }
    else if (indexPath.row == 3) {
        [self chooseBirthday];
    }
    else if (indexPath.row == 4) {
        [self editSign];
    }
    else if (indexPath.row == 5) {
        // 不做处理
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MMAddImageCellDelegate
- (void)addImage:(UIImageView *)imageView {
    [UIActionSheet showActionSheet:nil
                          delegate:self
                 cancelButtonTitle:@"取消"
            destructiveButtonTitle:nil
                               tag:MMActionSheetTypePhoto
                        showInView:self.view
                 otherButtonTitles:@[@"拍照",@"从相册中选取"]];
}

#pragma mark - UIActionSheetDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (actionSheet.tag) {
        case MMActionSheetTypeSexy:
        {
            if (buttonIndex == 1) {
                self.tableViewModel.userSexyCellModel.subTitle = @"男";
            }
            else if (buttonIndex == 2) {
                self.tableViewModel.userSexyCellModel.subTitle = @"女";
            }
            
        }
            break;
        case MMActionSheetTypePhoto:
        {
            if (buttonIndex == 1) {
                [self takePhoto];
            }
            else if (buttonIndex == 2) {
                [self choosePhoto];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(savaImage:)  withObject:img afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
