//
//  UIColor+Hex.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/04/18.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(int)aRGB alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexRGB:(int)aRGB;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)tableViewBackgroundColor;
+ (UIColor *)webViewBackgroundColor;

@end
