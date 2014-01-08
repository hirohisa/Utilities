//
//  NSString+Calcurate.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 13/06/10.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)
- (CGSize)sizeForWidth:(CGFloat)width font:(UIFont *)font
{
	CGSize boundingSize = CGSizeMake(width, CGFLOAT_MAX);
	CGSize size = [self sizeWithFont:font
                        constrainedToSize:boundingSize
                            lineBreakMode:NSLineBreakByCharWrapping];
	return size;
}

//
// references
// http://blog.sarabande.jp/post/61367307586
// http://punchdrunker.github.io/iOSEmoji/table_html/
// http://ja.wikipedia.org/wiki/Unicode
//
- (NSUInteger)numberOfComposedCharacterSequences
{
    __block NSUInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              ++count;
                          }
     ];

    return count;
}

- (NSString *)substringComposedCharacterSequencesToIndex:(NSUInteger)to
{
    __block NSMutableString *string = [@"" mutableCopy];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if ([string numberOfComposedCharacterSequences] < to) {
                                  [string appendString:substring];
                              }
                          }
     ];
    return [string copy];
}
@end