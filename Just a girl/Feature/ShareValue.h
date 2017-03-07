//
//  ShareValue.h
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface ShareValue : NSObject

+ (ShareValue *)instance;

@property (nonatomic, strong) UserModel *user;

@end
