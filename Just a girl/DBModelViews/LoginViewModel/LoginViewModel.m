//
//  LoginViewModel.m
//  Just a girl
//
//  Created by xiang on 16/7/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "LoginViewModel.h"
#import "ValidatePhoneNumber.h"

@interface LoginViewModel ()

@property (nonatomic, strong) RACCommand *loginCommand;

@end

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        self.loginCommand = [[RACCommand alloc] initWithEnabled:[self validateLoginInputs] signalBlock:^RACSignal *(id input) {
            @strongify(self);
#warning 需要修改
            return [RACSignal empty];
        }];
    }
    
    return self;
}

- (RACSignal *)validateLoginInputs {
    return [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password){
        return @([ValidatePhoneNumber checkPhoneNumberInput:username] && password.length > 0);
    }];
}

@end
