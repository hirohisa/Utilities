//
//  UIView+Calcurate.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/06/10.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import "UIView+Calcurate.h"

@implementation UIView (Calcurate)
-(CGFloat)textHeight:(NSString*)text width:(CGFloat)width font:(UIFont *)font
{
	CGSize boundingSize = CGSizeMake(width, CGFLOAT_MAX);
	CGSize labelsize = [text sizeWithFont:font
                        constrainedToSize:boundingSize
                            lineBreakMode:UILineBreakModeWordWrap];
	return labelsize.height;
}
@end
