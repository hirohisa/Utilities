//
//  UTDefinitions.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/05/07.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

extern void SwizzleInstanceMethod(Class c, SEL original, SEL alternative);

// logging
#ifdef DEBUG
# define DEBUG_LOG NSLog(@"%s", __func__)
# define LOG(fmt, ...) NSLog((@"%s" fmt), __PRETTY_FUNCTION__, __VA_ARGS__)
#else
# define DEBUG_LOG ;
# define LOG(...) ;
#endif

//
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define __IS_RETINA__ [UIScreen mainScreen].scale == 2.

//
#define __OS_VERSION__ [[[UIDevice currentDevice] systemVersion] floatValue]
#define OS_REQUIRED(VERSION) __OS_VERSION__ >= VERSION

// weak, block
#if __has_feature(objc_arc_weak) // iOS 5 or above
#define __block_weak        __weak
#elif __has_feature(objc_arc)    // iOS 4.X
#define __block_weak        __unsafe_unretained
#else                            // iOS 3.X or non-ARC projects
#define __block_weak        __block
#endif
