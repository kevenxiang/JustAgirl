//
//  MainPageViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MainPageViewController.h"
#import "ScanImageViewController.h"
#import "LinkDetailViewController.h"

#import "ImageTypeCell.h"
#import "LinkTypeCell.h"
#import "TextTypeCell.h"

#import "MainPageModelView.h"

@interface MainPageViewController () <UITableViewDelegate, UITableViewDataSource, ImageTypeCellDelegate, LinkTypeCellDelegate>
{
    NSMutableArray *tableDataAry;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation MainPageViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.navigationController.hidesBarsOnSwipe = YES;
    
    /*
    //扩展用的代码
    //初始化一个供App Groups使用的NSUserDefaults对象
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.girlShare"];
    NSString *groupString = [userDefaults valueForKey:@"share-url"];
    //读取数据
    NSLog(@"扩展==%@,%@", [userDefaults valueForKey:@"share-url"], groupString);
     */
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 330.0f;
    } else if (indexPath.row == 2 || indexPath.row == 3) {
        return 220.0f;
    }
    return 310.0f;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *ImageCellID = @"ImageCellID";
        ImageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTypeCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        return cell;
    } else if (indexPath.row == 2 || indexPath.row == 3) {
        static NSString *TextCellID = @"TextCellID";
        TextTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextTypeCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else {
        static NSString *LinkCellID = @"LinkCellID";
        LinkTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:LinkCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkTypeCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.indexRow = indexPath.row;
            cell.delegate = self;
        }
        
        return cell;
    }
    
}

#pragma mark - ImageTypeCellDelegate 
- (void)tapImage:(UIImage *)img {
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.hidesBottomBarWhenPushed = YES;
    scanImageCtr.scanImage = img;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
}

#pragma mark - LinkTypeCellDelegate
- (void)linkClickedWithIndexRow:(NSInteger)indexRow {
    LinkDetailViewController *linkDetail = [[LinkDetailViewController alloc] init];
    linkDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:linkDetail animated:YES];
}

#pragma mark - gettings and settings
- (void)findData {
    if (!tableDataAry) {
        tableDataAry = [[NSMutableArray alloc] init];
    }
    
    NSArray *resultAry = [MainPageModelView findDataFromDB];
    [tableDataAry addObjectsFromArray:resultAry];
    [self.mTableView reloadData];
}

@end
