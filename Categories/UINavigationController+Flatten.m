//
//  UINavigationController+Flatten.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/05/06.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "UINavigationController+Flatten.h"

void SwizzleInstanceMethodd(Class c, SEL original, SEL alternative)
{
    Method orgMethod = class_getInstanceMethod(c, original);
    Method altMethod = class_getInstanceMethod(c, alternative);
    if(class_addMethod(c, original, method_getImplementation(altMethod), method_getTypeEncoding(altMethod))) {
        class_replaceMethod(c, alternative, method_getImplementation(orgMethod), method_getTypeEncoding(orgMethod));
    } else {
        method_exchangeImplementations(orgMethod, altMethod);
    }
}

static CGFloat const kFlattenPadding = 5.;

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

- (void)layoutSubviews
{}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self.backgroundColor CGColor]);
    CGContextFillRect(context, rect);

    context = UIGraphicsGetCurrentContext();
    rect = CGRectMake(kFlattenPadding, kFlattenPadding, CGRectGetWidth(rect)-kFlattenPadding*2, CGRectGetHeight(rect)-kFlattenPadding);
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
        navigationBar.backgroundColor = [UIColor whiteColor];
        navigationBar.color = color;
        navigationBar.delegate = self;
        [self setValue:navigationBar forKey:@"navigationBar"];
    }
    return self;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
{
    LOG(@"%@", item.title);
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{}

@end

@interface UIViewController (Flatten)
@end

@implementation UIViewController (Flatten)
+ (void)load
{
    @autoreleasepool {
        SwizzleInstanceMethodd(self, @selector(initWithNibName:bundle:), @selector(_initWithNibName:bundle:));
    }
}

- (id)_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [self _initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self.navigationItem setHidesBackButton:YES];
    return self;
}

@end
