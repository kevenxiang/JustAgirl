//
//  ShareValue.m
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ShareValue.h"
#import "NSObject+MJKeyValue.h"

#define kUserDefaults              @"kUserDefaults"

@implementation ShareValue

+ (ShareValue *)instance {
    static ShareValue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)setUser:(UserModel *)user {
    if (user) {
        NSDictionary *dic = user.keyValues;
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:dic];
        [[NSUserDefaults standardUserDefaults] setValue:userData forKey:kUserDefaults];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaults];
    }
}

- (UserModel *)user {
    NSData *muUserData = [[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaults];
    if (muUserData) {
        NSDictionary *mcUserDic = [NSKeyedUnarchiver unarchiveObjectWithData:muUserData];
        return [UserModel objectWithKeyValues:mcUserDic];
    } else {
        return nil;
    }
}

@end
