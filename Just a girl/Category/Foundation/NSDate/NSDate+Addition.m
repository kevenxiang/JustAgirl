//
//  NSDate+Addition.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSDate+Addition.h"
#import "NSDate+Utilities.h"
#import "NSDate+Extension.h"
#import "NSDate+Helper.h"

@implementation NSDate (Addition)
+ (NSString *)currentDateStringWithFormat:(NSString *)format
{
    NSDate *chosenDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:chosenDate];
    return date;
}
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds {
    NSDate *date = [NSDate date];
    NSDateComponents *components = [NSDateComponents new];
    [components setSecond:seconds];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateSecondsAgo = [calendar dateByAddingComponents:components toDate:date options:0];
    return dateSecondsAgo;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}
- (NSString *)dateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:self];
    return date;
}

- (NSString *)dateStringCustom {
    if ([self isToday]) {
        NSString *dateString = [self dateWithFormat:@"HH:mm"];
        return dateString;
    } else if ([self isYesterday]) {
        NSString *dateString = [self dateWithFormat:@"昨天HH:mm"];
        return dateString;
    }

    NSDate *today = [NSDate date];
    if ([today isTypicallyWeekend]) {
        NSString *dateString = [self dateWithFormat:@"yyyy年MM月dd日 HH:mm"];
        return dateString;
    } else {
        NSDate *begineOfWeek = [today beginningOfWeek];
        if ([self timeIntervalSinceDate:begineOfWeek] > 0.0 && [self isTypicallyWorkday]) {
            NSString *weekDay = [NSDate dayFromWeekday:self];
            NSString *dateString = [self dateWithFormat:@"HH:mm"];
            dateString = [NSString stringWithFormat:@"%@ %@", weekDay, dateString];
            return dateString;
        } else {
            NSString *dateString = [self dateWithFormat:@"yyyy年MM月dd日 HH:mm"];
            return dateString;
        }
    }
}
@end
