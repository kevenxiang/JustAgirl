//
//  MyCollectViewController.m
//  Just a girl
//
//  Created by xiang on 16/6/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyCollectShopCell.h"
#import "MyCollectArticleCell.h"

@interface MyCollectViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation MyCollectViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的收藏";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *MyCollectShopCellID = @"MyCollectShopCellID";
        MyCollectShopCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCollectShopCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCollectShopCell" owner:nil options:nil]  lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else {
        static NSString *MyCollectArticleCellID = @"MyCollectArticleCellID";
        MyCollectArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCollectArticleCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCollectArticleCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    } else {
    
    }
}

@end
