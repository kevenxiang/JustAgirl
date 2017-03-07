//
//  PrivacyDetailViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/9.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "PrivacyDetailViewController.h"
#import "ASFSharedViewTransition.h"

static CGFloat kImageOriginHight = 140;
//static CGFloat kTempHeight = 80.0f;

@interface PrivacyDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PrivacyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 20, 60, 40);
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:backBtn];
    
    self.topImgView = [[UIImageView alloc] init];
    self.topImgView.image = self.topImg;
    self.topImgView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, kImageOriginHight);
    self.tableView.tableHeaderView = self.topImgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.textLabel.text = @"biaoti";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"biaoti %ld", (long)indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.topImgView.frame;
        rect.origin.y = offset.y;
        rect.size.height = kImageOriginHight - offset.y;
        self.topImgView.frame = rect;
    }
}

#pragma mark - ASFSharedViewTransitionDataSource
- (UIView *)sharedView {
    return _topImgView;
}

#pragma mark - event responds
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
