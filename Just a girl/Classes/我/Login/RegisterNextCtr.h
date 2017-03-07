//
//  RegisterNextCtr.h
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RegisterCompletion)();

@interface RegisterNextCtr : BaseViewController

@property (nonatomic, copy) RegisterCompletion completion;

- (void)registerCompletion:(RegisterCompletion)block;

@end
