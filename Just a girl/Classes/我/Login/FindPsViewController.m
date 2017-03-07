//
//  FindPsViewController.m
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "FindPsViewController.h"
#import "FindPsDoneViewController.h"

@interface FindPsViewController ()

@end

@implementation FindPsViewController

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
- (IBAction)nextAction:(id)sender {
    FindPsDoneViewController *findD = [[FindPsDoneViewController alloc] init];
    [self.navigationController pushViewController:findD animated:YES];
}


@end
