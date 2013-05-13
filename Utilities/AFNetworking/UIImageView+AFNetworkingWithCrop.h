//
//  UIImageView+AFNetworkingWithCrop.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/08/06.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AFNetworkingWithCrop)
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size;
- (void)setImageWithURL:(NSURL *)url crop:(CGSize)size;
@end
