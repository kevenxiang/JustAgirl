//
//  LinkDetailViewController.m
//  Just a girl
//
//  Created by xiang on 16/6/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "LinkDetailViewController.h"

@interface LinkDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LinkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
