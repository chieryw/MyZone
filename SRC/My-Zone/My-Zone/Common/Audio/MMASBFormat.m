//
//  MMASBFormat.m
//  My-Zone
//
//  Created by chiery on 2016/11/16.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMASBFormat.h"

@implementation MMASBFormat

+ (void)configASBFormat:(AudioStreamBasicDescription *)format {
    format->mSampleRate = 44100.0;
    
    format->mFormatID = kAudioFormatLinearPCM;
    format->mFormatFlags =
    kLinearPCMFormatFlagIsBigEndian
    | kLinearPCMFormatFlagIsSignedInteger
    | kLinearPCMFormatFlagIsPacked;
    format->mFramesPerPacket  = 1;
    format->mChannelsPerFrame = 2;
    format->mBytesPerFrame    = format->mChannelsPerFrame * sizeof (SInt16);
    format->mBytesPerPacket   = format->mBytesPerFrame;
    format->mBitsPerChannel   = 16;
}

@end
