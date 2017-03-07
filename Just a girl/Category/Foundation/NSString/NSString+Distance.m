//
//  NSString+Distance.m
//  APP_iOS
//
//  Created by 林小果 on 15/8/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "NSString+Distance.h"

@implementation NSString (Distance)

- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)distanceString {
    if (self != nil || self.length > 0) {
        if ([self isPureInt]) {
            NSInteger distance = [self integerValue];
            if (distance < 10000) {
                NSString *str = [NSString stringWithFormat:@"距离%.1f公里", distance/1000.0];
                return str;
            } else if (distance > 10000) {
                NSString *str = [NSString stringWithFormat:@"距离%.0f公里", distance/1000.0];
                return str;
            }
        }
    }
    return @"距离未知";
}
@end
