//
//  FileCache.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/06/19.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCache : NSObject

+ (FileCache *)sharedCache;
- (BOOL)flush;
- (BOOL)set:(NSString *)path data:(NSData *)data;
- (NSData *)get:(NSString *)path;
@end
