//
//  MMPersonTableViewModel.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonTableViewModel.h"
#import "MMRequestPostUploadImage.h"

@implementation MMAddImageCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.images = [@[
                     @"EmptPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto"
                     ] mutableCopy];
}

@end

@implementation MMPersonMessageCellModel


@end

@interface MMPersonTableViewModel ()

@property (nonatomic, strong) NSMutableArray *cellConfigArray;

@end

NSString *TMP_UPLOAD_IMG_PATH=@"";

@implementation MMPersonTableViewModel

- (void)saveImage:(UIImage *)image {
    
    // 添加相应的图片到对应的文件夹中
    UIImage *newImg=[MMRequestPostUploadImage imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    [self saveImage:newImg WithName:[NSString stringWithFormat:@"%@%@",[MMRequestPostUploadImage generateUuidString],@".jpg"]];
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName

{
    NSLog(@"===TMP_UPLOAD_IMG_PATH===%@",TMP_UPLOAD_IMG_PATH);
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    // and then we write it out
    TMP_UPLOAD_IMG_PATH=fullPathToFile;
    NSArray *nameAry=[TMP_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
    NSLog(@"===new fullPathToFile===%@",fullPathToFile);
    NSLog(@"===new FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);
    
    [imageData writeToFile:fullPathToFile atomically:NO];
}

- (IBAction)onPostData:(id)sender {
    if([TMP_UPLOAD_IMG_PATH isEqualToString:@""]){
        [MMRequestPostUploadImage postRequestWithURL:@"/tour/uploadfile.htm?fileType=headImg" postParems:nil picFilePath:nil picFileName:nil result:^(NSError *error, NSDictionary *resultInfo) {
            if (resultInfo && !error) {
                // 成功处理
            }
            else {
                // 出错的处理
            }
        }];
    }else{
        NSLog(@"有图标上传");
        NSArray *nameAry=[TMP_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
        [MMRequestPostUploadImage postRequestWithURL:@"/tour/uploadfile.htm?fileType=headImg" postParems:nil picFilePath:TMP_UPLOAD_IMG_PATH picFileName:[nameAry objectAtIndex:[nameAry count]-1] result:^(NSError *error, NSDictionary *resultInfo) {
            if (resultInfo && !error) {
                // 成功处理
            }
            else {
                // 出错的处理
            }
        }];
    }
    
}

- (MMAddImageCellModel *)addImageCellModel {
    if (!_addImageCellModel) {
        _addImageCellModel = [[MMAddImageCellModel alloc] init];
    }
    return _addImageCellModel;
}

- (MMPersonMessageCellModel *)userNameCellModel {
    if (!_userNameCellModel) {
        _userNameCellModel = [[MMPersonMessageCellModel alloc] init];
        _userNameCellModel.icon = @"Name";
        _userNameCellModel.title = @"姓名";
        _userNameCellModel.defaultSubTitle = @"请输入您的姓名";
    }
    return _userNameCellModel;
}

- (MMPersonMessageCellModel *)userSexyCellModel {
    if (!_userSexyCellModel) {
        _userSexyCellModel = [[MMPersonMessageCellModel alloc] init];
        _userSexyCellModel.icon = @"Sexy";
        _userSexyCellModel.title = @"性别";
        _userSexyCellModel.defaultSubTitle = @"请选择您的性别";
    }
    return _userSexyCellModel;
}

- (MMPersonMessageCellModel *)userBirthdayCellModel {
    if (!_userBirthdayCellModel) {
        _userBirthdayCellModel = [[MMPersonMessageCellModel alloc] init];
        _userBirthdayCellModel.icon = @"BirthDay";
        _userBirthdayCellModel.title = @"出生日期";
        _userBirthdayCellModel.defaultSubTitle = @"请选择您的出生日期";
    }
    return _userBirthdayCellModel;
}

- (MMPersonMessageCellModel *)userSignCellModel {
    if (!_userSignCellModel) {
        _userSignCellModel = [[MMPersonMessageCellModel alloc] init];
        _userSignCellModel.icon = @"Sign";
        _userSignCellModel.title = @"签名";
        _userSignCellModel.defaultSubTitle = @"请输入您的签名";
    }
    return _userSignCellModel;
}

- (MMPersonMessageCellModel *)userGradeCellModel {
    if (!_userGradeCellModel) {
        _userGradeCellModel = [[MMPersonMessageCellModel alloc] init];
        _userGradeCellModel.icon = @"Rank";
        _userGradeCellModel.title = @"身份";
        _userGradeCellModel.defaultSubTitle = @"普通";
    }
    return _userGradeCellModel;
}

@end
