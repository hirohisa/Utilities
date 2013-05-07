//
//  NSDate+Comparison.m
//  Utilities
//
//  Created by Hirohisa Kawasaki on 12/04/18.
//  Copyright (c) 2012年 Hirohisa Kawasaki. All rights reserved.
//

#import "NSDate+Comparison.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Comparison)

- (BOOL)isWithinMonth
{
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:-1];
    NSDate *date = [CURRENT_CALENDAR dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
    
    return ([self laterDate:date] == self);
}

- (BOOL)isWithinDay
{
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setDay:-1];
    NSDate *date = [CURRENT_CALENDAR dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
    
    return ([self laterDate:date] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
    return ([self laterDate:aDate] == self);
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

@end
