//
//  UIImageView+AFNetworkingWithCropAndCache.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/08/06.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import "UIImageView+AFNetworkingWithCropAndCache.h"
#import "UIImageView+AFNetworking.h"
#import "FileCache.h"

@implementation UIImageView (AFNetworkingWithCropAndCache)

#pragma mark - public
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size
{
    [self setImageWithURL:url placeholderImage:placeholderImage crop:size cache:YES];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size cache:(BOOL)cache
{
    NSData *data = nil;
    if ((data = [[FileCache sharedCache] get:[url absoluteString]])) {
        self.image = [self crop:[[UIImage alloc] initWithData:data] size:size];
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    __block UIImageView *blockSelf = self;
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        if (cache) {
            [[FileCache sharedCache] set:[url absoluteString]
                                    data:[[NSData alloc] initWithData:UIImagePNGRepresentation(image)]];
        }
         blockSelf.image = [blockSelf crop:image size:size];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
    }];
}


#pragma mark - private
#pragma mark - crop
-(UIImage*)crop:(UIImage*)image size:(CGSize)size
{
    return [self trim:image size:[self trimSize:image size:size]];
}

- (UIImage*)trim:(UIImage*)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *trimmedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return trimmedImage;
}

- (CGSize)trimSize:(UIImage*)image size:(CGSize)size
{
    CGFloat widthRatio  = image.size.width/size.width;
    CGFloat heightRatio = image.size.height/size.height;
    CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    return CGSizeMake(size.width * ratio, size.height * ratio);
}
@end
