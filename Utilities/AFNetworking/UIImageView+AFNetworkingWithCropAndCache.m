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
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage cached:(BOOL)cached finished:(void (^)(BOOL))finished
{
    __block UIImageView *blockSelf = self;
    [self requestImageWithURL:url placeholderImage:placeholderImage cached:cached response:^(UIImage *image){
        if (image != nil) {
            blockSelf.image = image;
        }
        finished(YES);
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size finished:(void (^)(BOOL))finished
{
    [self setImageWithURL:url placeholderImage:placeholderImage crop:size cached:YES finished:finished];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage crop:(CGSize)size cached:(BOOL)cached finished:(void (^)(BOOL))finished
{
    __block UIImageView *blockSelf = self;
    [self requestImageWithURL:url placeholderImage:placeholderImage cached:cached response:^(UIImage *image){
        if (image != nil) {
            blockSelf.image = [blockSelf crop:image size:size];
        }
        finished(YES);
    }];
}

#pragma mark - private
#pragma mark - request
- (void)requestImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage cached:(BOOL)cached response:(void (^)(UIImage *))response
{
    NSData *data = nil;
    if ((data = [[FileCache sharedCache] get:[url absoluteString]])) {
        response([[UIImage alloc] initWithData:data]);
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *res, UIImage *image){
        response(image);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *res, NSError *error){
        response(nil);
    }];
}

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
