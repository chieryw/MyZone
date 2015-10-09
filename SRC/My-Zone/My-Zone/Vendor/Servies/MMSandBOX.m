//
//  MMSandBOX.m
//  My-Zone
//
//  Created by chiery on 15/10/3.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMSandBOX.h"

@implementation MMSandBOX

+ (NSString *)documentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)libraryPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)preferencePath {
    return [[self libraryPath] stringByAppendingPathComponent:@"Preferences"];
}

+ (NSString *)applicationSupportPath {
    return NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)tempPath {
    return NSTemporaryDirectory();
}


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey
                                   error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}

@end
