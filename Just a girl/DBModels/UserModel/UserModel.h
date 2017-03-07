//
//  UserModel.h
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

//用户信息

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *user_ip;
@property (nonatomic, copy) NSString *headImg;

@property (nonatomic, strong) NSString *token;

@end
