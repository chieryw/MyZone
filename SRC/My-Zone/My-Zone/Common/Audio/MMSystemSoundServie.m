//
//  MMSystemSoundServie.m
//  My-Zone
//
//  Created by chiery on 2016/10/26.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSystemSoundServie.h"

@interface MMSystemSoundServie ()
@property(nonatomic, copy) void(^completeHandle)(SystemSoundID soundID,void * clientData);
@end

@implementation MMSystemSoundServie

+ (instancetype)getInstance {
    static MMSystemSoundServie *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [MMSystemSoundServie new];
    });
    return __instance;
}

/**
 播放完声音的回调

 @param soundID 系统声音ID
 @param clientData 回调时传递的参数
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
    if ([[MMSystemSoundServie getInstance] completeHandle]) {
        [MMSystemSoundServie getInstance].completeHandle(soundID,clientData);
        // 执行完成回调之后，将回调数据置为nil，方便下次使用
        [MMSystemSoundServie getInstance].completeHandle = nil;
    }
}

- (void)playSoundWithName:(NSString *)fileName
      palySystemSoundType:(MMPlaySystemSoundType)type
           completeHandle:(void (^)(SystemSoundID, void *))handle {
    
    // 将回调寄存
    if (!self.completeHandle) self.completeHandle = handle;
    
    // 因为系统的播放声音的API，只能播放本地资源，只能从bundle中取出资源
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    if (type == MMPlaySystemSoundTypeDefault) AudioServicesPlaySystemSound(soundID);//播放音效
    else AudioServicesPlayAlertSound(soundID);//播放音效并震动
}

@end
