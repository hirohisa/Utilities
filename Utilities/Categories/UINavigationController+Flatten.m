//
//  UINavigationController+Flatten.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/05/06.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UINavigationController+Flatten.h"
#import "UTDefinitions.h"

@interface UIFlattenNavigationBar : UINavigationBar
@property (nonatomic, strong) UIColor *color;
@end

@implementation UIFlattenNavigationBar

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.tintColor = _color;
    [self layoutIfNeeded];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self.color CGColor]);
    CGContextFillRect(context, rect);
}

@end

@interface UINavigationController (FlattenPrivate) <UINavigationBarDelegate>
@end

@implementation UINavigationController (Flatten)

- (id)initWithRootViewController:(UIViewController *)rootViewController flattenColor:(UIColor *)color
{
    if ((self = [self initWithRootViewController:rootViewController])) {
        UIFlattenNavigationBar *navigationBar = [[UIFlattenNavigationBar alloc] initWithFrame:CGRectZero];
        navigationBar.backgroundColor = [UIColor clearColor];
        navigationBar.color = color;
        navigationBar.delegate = self;
        [self setValue:navigationBar forKey:@"navigationBar"];
    }
    return self;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
{
    [item.leftBarButtonItem.customView setHidden:([navigationBar.items count] <= 1)];
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{}

@end
