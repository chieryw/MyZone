//
//  MMAudioQueueServie.m
//  My-Zone
//
//  Created by chiery on 2016/11/14.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMAudioCoreRecorder.h"
#import <AVFoundation/AVFoundation.h>


static const int kNumberBuffers = 3;
typedef struct {
    AudioStreamBasicDescription  mDataFormat;                   // 2 文件格式描述
    AudioQueueRef                mQueue;                        // 3 The recording audio queue created by your application.
    AudioQueueBufferRef          mBuffers[kNumberBuffers];      // 4 An array holding pointers to the audio queue buffers managed by the audio queue.
    AudioFileID                  mAudioFile;                    // 5 An audio file object representing the file into which your program records audio data.
    UInt32                       bufferByteSize;                // 6 The size, in bytes, for each audio queue buffer. This value is calculated in these examples in the DeriveBufferSize function, after the audio queue is created and before it is started
    SInt64                       mCurrentPacket;                // 7 The packet index for the first packet to be written from the current audio queue buffer.
    bool                         mIsRunning;                    // 8 A Boolean value indicating whether or not the audio queue is running.
    
} AQRecorderState;


@interface MMAudioCoreRecorder (){
    AQRecorderState recordState;
}

@end

@implementation MMAudioCoreRecorder

static void HandleInputBuffer (void                                 *aqData,
                               AudioQueueRef                        inAQ,
                               AudioQueueBufferRef                  inBuffer,
                               const AudioTimeStamp                 *inStartTime,
                               UInt32                               inNumPackets,
                               const AudioStreamPacketDescription   *inPacketDesc) {
    AQRecorderState *pAqData = (AQRecorderState *) aqData;
    
    if (inNumPackets == 0 &&
        pAqData->mDataFormat.mBytesPerPacket != 0)
        inNumPackets =
        inBuffer->mAudioDataByteSize / pAqData->mDataFormat.mBytesPerPacket;
    
    // 计算文件写入的标记位
    if (AudioFileWritePackets (pAqData->mAudioFile,
                               false,
                               inBuffer->mAudioDataByteSize,
                               inPacketDesc,
                               pAqData->mCurrentPacket,
                               &inNumPackets,
                               inBuffer->mAudioData
                               ) == noErr) {
        pAqData->mCurrentPacket += inNumPackets;
    }
    if (pAqData->mIsRunning == 0) return;
    
    // 使用完成将buffer回传
    AudioQueueEnqueueBuffer (pAqData->mQueue,
                             inBuffer,
                             0,
                             NULL
                             );
}

// 计算每个buffer缓冲区域的最大的size
void DeriveBufferSize (AudioQueueRef                audioQueue,
                       AudioStreamBasicDescription  ASBDescription,
                       Float64                      seconds,
                       UInt32                       *outBufferSize) {
    static const int maxBufferSize = 0x50000;
    
    int maxPacketSize = ASBDescription.mBytesPerPacket;
    if (maxPacketSize == 0) {
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
        AudioQueueGetProperty (audioQueue,
                               kAudioQueueProperty_MaximumOutputPacketSize,
                               &maxPacketSize,
                               &maxVBRPacketSize);
    }
    
    Float64 numBytesForTime =
    ASBDescription.mSampleRate * maxPacketSize * seconds;
    *outBufferSize = (UInt32)(numBytesForTime < maxBufferSize ? numBytesForTime : maxBufferSize);
}

// 为文件设置magic cookie，这个常用与MPEG 4 ACC
OSStatus SetMagicCookieForFile (AudioQueueRef inQueue,
                                AudioFileID   inFile) {
    OSStatus result = noErr;
    UInt32 cookieSize;
    
    if (AudioQueueGetPropertySize (inQueue,
                                   kAudioQueueProperty_MagicCookie,
                                   &cookieSize) == noErr) {
        char* magicCookie =(char *) malloc (cookieSize);
        if (AudioQueueGetProperty (inQueue,
                                   kAudioQueueProperty_MagicCookie,
                                   magicCookie,
                                   &cookieSize) == noErr)
            result =    AudioFileSetProperty (inFile,
                                              kAudioFilePropertyMagicCookieData,
                                              cookieSize,
                                              magicCookie);
        free (magicCookie);
    }
    return result;
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

// 使用存在的ASB信息
- (void)existenseABSFormat {
    UInt32 dataFormatSize = sizeof (recordState.mDataFormat);
    
    AudioQueueGetProperty (recordState.mQueue,
                           kAudioQueueProperty_StreamDescription,
                           &recordState.mDataFormat,
                           &dataFormatSize);
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
                            &recordState.mDataFormat,
                            kAudioFileFlags_EraseFile,
                            &recordState.mAudioFile);
}

- (void)startRecording {
    
    [self setupAudioFormat:&recordState.mDataFormat];
    [self createAudioSaveFile];
    recordState.mCurrentPacket = 0;
    
    OSStatus status;
    status = AudioQueueNewInput(&recordState.mDataFormat,
                                HandleInputBuffer,
                                &recordState,
                                CFRunLoopGetCurrent(),
                                kCFRunLoopCommonModes,
                                0,
                                &recordState.mQueue);
    
    if (status == 0) {
        DeriveBufferSize(recordState.mQueue, recordState.mDataFormat, 0.5, &recordState.bufferByteSize);
        for (int i = 0; i < kNumberBuffers; i++) {
            AudioQueueAllocateBuffer(recordState.mQueue, recordState.bufferByteSize, &recordState.mBuffers[i]);
            AudioQueueEnqueueBuffer(recordState.mQueue, recordState.mBuffers[i], 0, nil);
        }
        
        recordState.mIsRunning = true;
        status = AudioQueueStart(recordState.mQueue, NULL);
    }
}

- (void)stopRecording {
    recordState.mIsRunning = false;
    
    AudioQueueStop(recordState.mQueue, true);
    
    for (int i = 0; i < kNumberBuffers; i++) {
        AudioQueueFreeBuffer(recordState.mQueue, recordState.mBuffers[i]);
    }
    
    AudioQueueDispose(recordState.mQueue, true);
    AudioFileClose(recordState.mAudioFile);
}


@end
