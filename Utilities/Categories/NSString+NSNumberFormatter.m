//
//  NSString+NSNumberFormatter.m
//  Demo
//
//  Created by Hirohisa Kawasaki on 13/11/01.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import "NSString+NSNumberFormatter.h"

@implementation NSString (NSNumberFormatter)
+ (NSString *)stringWithDecimal:(NSInteger)decimal suffix:(NSString *)suffix
{
    NSNumber *number = [NSNumber numberWithInteger:decimal];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"%@%@",
            [formatter stringFromNumber:number], suffix];
}
@end
