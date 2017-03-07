//
//  ScanImageViewController.m
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ScanImageViewController.h"
#import "SKPanoramaView.h"

@interface ScanImageViewController ()

@property (nonatomic, strong) SKPanoramaView *panoramaView;

@end

@implementation ScanImageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.panoramaView) {
        _panoramaView = [[SKPanoramaView alloc] initWithFrame:self.view.frame image:self.scanImage];
        self.panoramaView.animationDuration = 10.0f; //Set the duration
        [self.view addSubview:self.panoramaView];
        [self.panoramaView startAnimating];
    }
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.panoramaView stopAnimating];
}

@end
