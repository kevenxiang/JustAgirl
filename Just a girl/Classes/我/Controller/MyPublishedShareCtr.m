//
//  MyPublishedShareCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyPublishedShareCtr.h"
#import "TextTypeCell.h"
#import "LinkTypeCell.h"
#import "ImageTypeCell.h"
#import "ScanImageViewController.h"

@interface MyPublishedShareCtr () <UITableViewDelegate, UITableViewDataSource, ImageTypeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end

@implementation MyPublishedShareCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的分享";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 220.0f;
    //    return 300.0f;
    return 330.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *TextCellID = @"TextCellID";
    //    TextTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID];
    //    if (cell == nil) {
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"TextTypeCell" owner:nil options:nil] lastObject];
    //    }
    //
    //    return cell;
    
    //    static NSString *LinkCellID = @"LinkCellID";
    //    LinkTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:LinkCellID];
    //    if (cell == nil) {
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkTypeCell" owner:nil options:nil] lastObject];
    //    }
    //
    //    return cell;
    
    static NSString *ImageCellID = @"ImageCellID";
    ImageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTypeCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
    }
    
    return cell;
    
}

#pragma mark - ImageTypeCellDelegate
- (void)tapImage:(UIImage *)img {
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.scanImage = img;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
}


@end
