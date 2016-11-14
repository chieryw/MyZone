//
//  MMAudioCorePlayer.m
//  My-Zone
//
//  Created by chiery on 2016/11/14.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAudioCorePlayer.h"
#import <AVFoundation/AVFoundation.h>


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
    AudioFileReadPackets (pAqData->mAudioFile,
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


// 创建文件路径
- (NSString *)getSavePath {
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:@"tempAudioRecord.caf"];
    return urlStr;
}

// 创建文件路径，用来存储音频数据
- (void)createAudioSaveFile {
    
    CFURLRef audioFileURL =
    CFURLCreateFromFileSystemRepresentation (NULL,
                                             (const UInt8 *)[[self getSavePath] UTF8String],
                                             strlen ([[self getSavePath] UTF8String]),
                                             false);
    
    AudioFileCreateWithURL (audioFileURL,
                            kAudioFileAIFFType,
                            &playerState.mDataFormat,
                            kAudioFileFlags_EraseFile,
                            &playerState.mAudioFile);
}

// 为录制设置初始ASB
- (void)setupAudioFormat:(AudioStreamBasicDescription*)format {
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
