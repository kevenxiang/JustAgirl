//
//  RegisterNextCtr.m
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "RegisterNextCtr.h"
#import "RegisterDoneCtr.h"

@interface RegisterNextCtr ()

@end

@implementation RegisterNextCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event responds
- (IBAction)nextAction:(id)sender {
    RegisterDoneCtr *done = [[RegisterDoneCtr alloc] init];
    [self.navigationController pushViewController:done animated:YES];
}

- (void)backAction {
    if (_completion) {
        _completion();
    }
}

- (void)registerCompletion:(RegisterCompletion)block {
    _completion = nil;
    _completion = [block copy];
}

@end
