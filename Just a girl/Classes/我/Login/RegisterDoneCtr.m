//
//  RegisterDoneCtr.m
//  Just a girl
//
//  Created by xiang on 16/7/20.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "RegisterDoneCtr.h"

@interface RegisterDoneCtr ()

@end

@implementation RegisterDoneCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event reponds
- (IBAction)doneRegistreAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
