//
//  RegisterViewController.m
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterNextCtr.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - event responds
- (IBAction)nextAction:(id)sender {
    RegisterNextCtr *next = [[RegisterNextCtr alloc] init];
    [next registerCompletion:^{
        NSLog(@"返回");
    }];
    [self.navigationController pushViewController:next animated:YES];
}


@end
