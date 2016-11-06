//
//  MMSystemSoundServie.h
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

typedef NS_ENUM(NSInteger, MMPlaySystemSoundType) {
    // 默认只是提示声音  静音模式没有声音
    MMPlaySystemSoundTypeDefault,
    // 播放声音并震动    静音模式只是震动
    MMPlaySystemSoundTypeAlert
};

@interface MMSystemSoundServie : NSObject

/**
 实例

 @return 返回对象本身
 */
+ (instancetype)getInstance;

/**
 播放音乐的请求以及回调

 @param fileName 即将播放资源的文件路径
 @param palySystemSoundType 播放声音的类型
 @param handle 播放完成的回调
 */
- (void)playSoundWithName:(NSString *)fileName
      palySystemSoundType:(MMPlaySystemSoundType)type
           completeHandle:(void (^)(SystemSoundID soundID,void *clientData))handle;

@end
