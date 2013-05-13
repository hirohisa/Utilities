//
//  UIImageView+AFNetworkingWithCropAndCache.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/08/06.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AFNetworkingWithCropAndCache)
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage cached:(BOOL)cached finished:(void (^)(BOOL))finished;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size finished:(void (^)(BOOL))finished;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size cached:(BOOL)cached finished:(void (^)(BOOL))finished;
@end
