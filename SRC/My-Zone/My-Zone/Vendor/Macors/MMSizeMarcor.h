//
//  MMSizeMarcor.h
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#ifndef My_Zone_MMSizeMarcor_h
#define My_Zone_MMSizeMarcor_h

#ifndef kScreenWidth
#define kScreenWidth            [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight           [[UIScreen mainScreen] bounds].size.height
#endif

#define kStatusBarHeight        20.0f
#define kNavigationBarHeight    44.0f
#define kTabBarHeight           49.0f
#define kToolBarHeight          44.0f
#define kContentHeight          (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)
#define kContentRect            CGRectMake(0, 0, kScreenWidth, kContentHeight)
#define kFullScreenRect         CGRectMake(0, 0, kScreenWidth, kScreenHeight)
#define kScaleInApp             1/[[UIScreen mainScreen] scale]


#define networkDomain           @"http://210.51.190.83:8080"
#define MMDebugUrl              @"http://localhost:3000"   // 测试使用的url


#endif
