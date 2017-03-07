//
//  ValidatePhoneNumber.m
//  DongBaiMore
//
//  Created by 向琼 on 16/1/24.
//  Copyright © 2016年 easycol. All rights reserved.
//

#import "ValidatePhoneNumber.h"

@implementation ValidatePhoneNumber

//判断手机号码是否合法
+ (BOOL)checkPhoneNumberInput:(NSString *)phoneNumber {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9]|70|77)\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    BOOL res1 = [regextestmobile evaluateWithObject:phoneNumber];
    BOOL res2 = [regextestcm evaluateWithObject:phoneNumber];
    BOOL res3 = [regextestcu evaluateWithObject:phoneNumber];
    BOOL res4 = [regextestct evaluateWithObject:phoneNumber];
    
    if (res1 || res2 || res3 || res4 ) {
        return YES;
    } else {
        return NO;
    }
    
}


@end
