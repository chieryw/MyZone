//
//  MMSandBOX.h
//  My-Zone
//
//  Created by chiery on 15/10/3.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMSandBOX : NSObject

+ (NSString *)documentPath;             // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libraryPath;              // 配置目录，配置文件存这里
+ (NSString *)applicationSupportPath;   //
+ (NSString *)cachePath;                // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tempPath;                 // 缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)preferencePath;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL; // 跳过用户数据  同步到iTunes

@end