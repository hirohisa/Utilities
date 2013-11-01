//
//  NSString+NSNumberFormatter.h
//  Demo
//
//  Created by Hirohisa Kawasaki on 13/11/01.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSNumberFormatter)
+ (NSString *)stringWithDecimal:(NSInteger)decimal suffix:(NSString *)suffix;
@end