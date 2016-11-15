//
//  MMAudioCorePlayer.m
//  My-Zone
//
//  Created by chiery on 2016/11/14.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAudioCorePlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "MMASBFormat.h"

static const int kNumberBuffers = 3;                              // 1
typedef struct {
    AudioStreamBasicDescription   mDataFormat;                    // 2
    AudioQueueRef                 mQueue;                         // 3
    AudioQueueBufferRef           mBuffers[kNumberBuffers];       // 4
    AudioFileID                   mAudioFile;                     // 5
    UInt32                        bufferByteSize;                 // 6
    SInt64                        mCurrentPacket;                 // 7
    UInt32                        mNumPacketsToRead;              // 8
    AudioStreamPacketDescription  *mPacketDescs;                  // 9
    bool                          mIsRunning;                     // 10
}AQPlayerState;

@interface MMAudioCorePlayer () {
    AQPlayerState playerState;
}

@end

@implementation MMAudioCorePlayer

static void HandleOutputBuffer (void                *aqData,
                                AudioQueueRef       inAQ,
                                AudioQueueBufferRef inBuffer) {
    AQPlayerState *pAqData = (AQPlayerState *) aqData;
    if (pAqData->mIsRunning == 0) return;
    UInt32 numBytesReadFromFile;
    UInt32 numPackets = pAqData->mNumPacketsToRead;
    AudioFileReadPacketData (pAqData->mAudioFile,
                          false,
                          &numBytesReadFromFile,
                          pAqData->mPacketDescs,
                          pAqData->mCurrentPacket,
                          &numPackets,
                          inBuffer->mAudioData);
    if (numPackets > 0) {
        inBuffer->mAudioDataByteSize = numBytesReadFromFile;
        AudioQueueEnqueueBuffer (pAqData->mQueue,
                                 inBuffer,
                                 (pAqData->mPacketDescs ? numPackets : 0),
                                 pAqData->mPacketDescs);
        pAqData->mCurrentPacket += numPackets;
    } else {
        AudioQueueStop (pAqData->mQueue,
                        false);
        pAqData->mIsRunning = false; 
    }
}

void DeriveBufferSize (AudioStreamBasicDescription ASBDesc,
                       UInt32                      maxPacketSize,
                       Float64                     seconds,
                       UInt32                      *outBufferSize,
                       UInt32                      *outNumPacketsToRead) {
    static const int maxBufferSize = 0x50000;
    static const int minBufferSize = 0x4000;
    
    if (ASBDesc.mFramesPerPacket != 0) {
        Float64 numPacketsForTime =
        ASBDesc.mSampleRate / ASBDesc.mFramesPerPacket * seconds;
        *outBufferSize = numPacketsForTime * maxPacketSize;
    } else {
        *outBufferSize =
        maxBufferSize > maxPacketSize ?
        maxBufferSize : maxPacketSize;
    }
    
    if (*outBufferSize > maxBufferSize &&
        *outBufferSize > maxPacketSize)
        *outBufferSize = maxBufferSize;
    else {
        if (*outBufferSize < minBufferSize)
            *outBufferSize = minBufferSize;
    }
    
    *outNumPacketsToRead = *outBufferSize / maxPacketSize;           
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    [MMASBFormat configASBFormat:&playerState.mDataFormat];
    [self openAudioFileForPlayback];
    [self settingPlaybackAudioQueueBufferSizeAndNumberOfPacketsToRead];
}

#pragma mark - Property setter
- (void)setVolume:(CGFloat)volume {
    _volume = volume;
    
    if ([self prepareForPlay]) {
        if (AudioQueueSetParameter(playerState.mQueue, kAudioQueueParam_Volume, volume) == 0) {
            NSLog(@"设置音效成功！");
        }
    }
}

// 创建文件路径
- (NSString *)getSavePath {
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:@"tempAudioRecord.mp3"];
    return urlStr;
}

- (void)openAudioFileForPlayback {
    
    CFURLRef audioFileURL =
    CFURLCreateFromFileSystemRepresentation (NULL,
                                             (const UInt8 *)[[self getSavePath] UTF8String],
                                             strlen ([[self getSavePath] UTF8String]),
                                             false);
    
    OSStatus result = AudioFileOpenURL (audioFileURL,
                      kAudioFileReadPermission,
                      0,
                      &playerState.mAudioFile
                      );
    if (result == 0) {
        NSLog(@"文件读取成功！！！可以准备播放了");
    }
    
    CFRelease (audioFileURL);
}

- (void)settingPlaybackAudioQueueBufferSizeAndNumberOfPacketsToRead {
    UInt32 maxPacketSize;
    UInt32 propertySize = sizeof (maxPacketSize);
    AudioFileGetProperty (playerState.mAudioFile,
                          kAudioFilePropertyPacketSizeUpperBound,
                          &propertySize,
                          &maxPacketSize);
    
    DeriveBufferSize (playerState.mDataFormat,
                      maxPacketSize,
                      0.5,
                      &playerState.bufferByteSize,
                      &playerState.mNumPacketsToRead);
}

- (BOOL)prepareForPlay {
    OSStatus status;
    status = AudioQueueNewOutput(&playerState.mDataFormat,
                                 HandleOutputBuffer,
                                 &playerState,
                                 CFRunLoopGetCurrent(),
                                 kCFRunLoopCommonModes,
                                 0,
                                 &playerState.mQueue);
    
    if (status == 0) return YES;
    return NO;
}

- (void)play {
    playerState.mCurrentPacket = true;
    
    if ([self prepareForPlay]) {
        for (int i = 0; i < kNumberBuffers; ++i) {
            AudioQueueAllocateBuffer (playerState.mQueue,
                                      playerState.bufferByteSize,
                                      &playerState.mBuffers[i]);
            
            HandleOutputBuffer (&playerState,
                                playerState.mQueue,
                                playerState.mBuffers[i]);
        }
        
        
        playerState.mIsRunning = true;
        OSStatus status = AudioQueueStart(playerState.mQueue, NULL);
        
        if (status == 0) {
            NSLog(@"当前录制对象已经开始");
        }
    }
}

- (void)stop {
    playerState.mIsRunning = false;
    
    AudioQueueStop(playerState.mQueue, true);
    
    for (int i = 0; i < kNumberBuffers; i++) {
        AudioQueueFreeBuffer(playerState.mQueue, playerState.mBuffers[i]);
    }
    
    AudioQueueDispose(playerState.mQueue, true);
    AudioFileClose(playerState.mAudioFile);
}

- (void)pause {
    AudioQueuePause(playerState.mQueue);
}

@end
