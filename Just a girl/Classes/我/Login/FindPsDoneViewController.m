//
//  FindPsDoneViewController.m
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "FindPsDoneViewController.h"

@interface FindPsDoneViewController ()

@end

@implementation FindPsDoneViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"找回密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event responds
- (IBAction)findPsDoneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
