//
//  UIColor+Hex.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/04/18.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(int)aRGB alpha:(CGFloat)alpha
{
	int aR = (aRGB >> 16) & 0xff;
    int aG = (aRGB >> 8) & 0xff;
    int aB = aRGB & 0xff;
    
    return [UIColor colorWithRed:((CGFloat)aR / 0xff)
                           green:((CGFloat)aG / 0xff)
                            blue:((CGFloat)aB / 0xff)
                           alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(int)aRGB
{
    return [self colorWithHexRGB:aRGB alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    static NSString *sTargets[2] = {@"#", @"0x"};
    
    for (int i = 0; i < sizeof(sTargets) / sizeof(NSString *); i++)
    {
        hexString = [[hexString lowercaseString] stringByReplacingOccurrencesOfString:sTargets[i] withString:@""];
    }
    
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
	return [self colorWithHexRGB:hexNum];
}

#pragma mark - view default color
+ (UIColor *)tableViewBackgroundColor
{
    static UIColor *_tableViewBackgroundColor = nil;
    if (_tableViewBackgroundColor == nil) {
        _tableViewBackgroundColor = [self colorWithView:[[UITableView alloc]initWithFrame:CGRectZero]];
    }
    return _tableViewBackgroundColor;
}

+ (UIColor *)webViewBackgroundColor
{
    static UIColor *_webViewBackgroundColor = nil;
    if (_webViewBackgroundColor == nil) {
        _webViewBackgroundColor = [self colorWithView:[[UIWebView alloc]initWithFrame:CGRectZero]];
    }
    return _webViewBackgroundColor;
}

+ (UIColor *)colorWithView:(UIView *)view
{
    if ([view respondsToSelector:@selector(backgroundColor)]) {
        return view.backgroundColor;
    }
    return [UIColor clearColor];
}


@end
