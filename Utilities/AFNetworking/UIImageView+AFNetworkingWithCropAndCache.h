//
//  UIImageView+AFNetworkingWithCropAndCache.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/08/06.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ImageViewCropTypeNone = 0,
    ImageViewCropTypeWidth = 1,
    ImageViewCropTypeHeight = 2
} ImageViewCropType;

@interface UIImageView (AFNetworkingWithCropAndCache)
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage cached:(BOOL)cached finished:(void (^)(BOOL))finished;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
                   crop:(CGSize)size type:(ImageViewCropType)type finished:(void (^)(BOOL))finished;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
                   crop:(CGSize)size  type:(ImageViewCropType)type
                 cached:(BOOL)cached finished:(void (^)(BOOL))finished;
@end
