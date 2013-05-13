//
//  FileCache.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/06/19.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import "FileCache.h"

@interface FileCache ()
@property (nonatomic, readonly) NSString *directoryPath;
@property (strong, nonatomic) NSFileManager *fileManager;
@end

@implementation FileCache
@synthesize fileManager = _fileManager;

+ (FileCache *)sharedCache
{
    static dispatch_once_t onceToken;
    __strong static FileCache *_shared = nil;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (id)init {
    self = [super init];
    if (self) {
        [self build];
    }
    
    return self;
}

#pragma mark - setter/getter
+ (NSString *)description
{
    return @"FileCache";
}

- (NSFileManager *)fileManager
{
    if (_fileManager == nil) {
        _fileManager = [[NSFileManager alloc]init];
    }
    return _fileManager;
}

- (NSString *)directoryPath
{
    const NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/%@", cachePath, [[self class] description]];
}

#pragma mark - public
- (BOOL)flush {
    return [self removeFiles];
}

- (BOOL)build {
    return [self existsOrCreatePath];
}

- (BOOL)set:(NSString *)path data:(NSData *)data
{
    //NSLog(@"%@", [self.fileManager contentsOfDirectoryAtPath:_directoryPath error:NULL]);
    BOOL result = [data writeToFile:[self encode:path] atomically:YES];
    return result;
}

- (NSData *)get:(NSString *)path {
    //NSLog(@"%@", [self.fileManager contentsOfDirectoryAtPath:_directoryPath error:NULL]);
    return [NSData dataWithContentsOfFile:[self encode:path]];
}

#pragma mark - private
- (BOOL)existsOrCreatePath {
    if (![self.fileManager fileExistsAtPath:self.directoryPath]) {
        return [self.fileManager createDirectoryAtPath:self.directoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return YES;
}

- (BOOL)removeFiles
{
    NSArray *filePaths = [self.fileManager contentsOfDirectoryAtPath:self.directoryPath error:NULL];
    for (NSString *filePath in filePaths) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", self.directoryPath, filePath];
        NSDictionary *dic = [self.fileManager attributesOfItemAtPath:path error:NULL];
        if (![[dic objectForKey:NSFileType] isEqualToString:NSFileTypeRegular]) {
            [self.fileManager removeItemAtPath:path error:NULL];
        }
    }
    return YES;
}

- (BOOL)remove:(NSString *)path
{
    return [self.fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@", self.directoryPath, [self encode:path]] error:NULL];
}

#pragma mark - encoding
- (NSString *)encode:(NSString *)path {
    NSString *escaped = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(
                                                                                          kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)path,
                                                                                          NULL,
                                                                                          (CFStringRef)@"!*'();:@&amp;=+$,/?%#[]",
                                                                                          kCFStringEncodingUTF8);

    return [NSString stringWithFormat:@"%@/%@", self.directoryPath, escaped];
}

@end
