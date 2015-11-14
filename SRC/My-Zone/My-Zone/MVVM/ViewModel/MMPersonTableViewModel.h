//
//  MMPersonTableViewModel.h
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAddImageCellModel : NSObject

@property (nonatomic, strong) NSMutableArray *images;

@end

@interface MMPersonMessageCellModel : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *defaultSubTitle;       // 默认的subTitle
@property (nonatomic, strong) NSString *subTitle;           // 真实的subTitle

@end

@interface MMPersonTableViewModel : NSObject

@property (nonatomic, strong) MMAddImageCellModel *addImageCellModel;
@property (nonatomic, strong) MMPersonMessageCellModel *userNameCellModel;
@property (nonatomic, strong) MMPersonMessageCellModel *userBirthdayCellModel;
@property (nonatomic, strong) MMPersonMessageCellModel *userSexyCellModel;
@property (nonatomic, strong) MMPersonMessageCellModel *userSignCellModel;
@property (nonatomic, strong) MMPersonMessageCellModel *userGradeCellModel;

/**
 *  对外的接口  用于操作对应的接口
 *
 *  @param image 图像数据
 */
- (void)saveImage:(UIImage *)image;

@end