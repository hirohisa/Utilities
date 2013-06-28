//
//  NSString+Calcurate.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/06/10.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import "NSString+Calcurate.h"

@implementation NSString (Calcurate)
-(CGSize)sizeForWidth:(CGFloat)width font:(UIFont *)font
{
	CGSize boundingSize = CGSizeMake(width, CGFLOAT_MAX);
	CGSize size = [self sizeWithFont:font
                        constrainedToSize:boundingSize
                            lineBreakMode:UILineBreakModeWordWrap];
	return size;
}
@end
