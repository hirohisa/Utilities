//
//  NSDate+Comparison.h
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/04/18.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Comparison)

- (BOOL)isWithinMonth;
- (BOOL)isWithinDay;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;

@end
