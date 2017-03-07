//
//  LoginViewModel.h
//  Just a girl
//  Created by xiang on 16/7/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "EXTScope.h"

@interface LoginViewModel : NSObject

@property (nonatomic, readonly) RACCommand *loginCommand;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
