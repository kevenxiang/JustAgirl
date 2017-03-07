//
//  MyShareViewController.m
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyShareViewController.h"
#import "SlideButtonView.h"
#import "TextTypeCell.h"
#import "LinkTypeCell.h"
#import "ImageTypeCell.h"
#import "ScanImageViewController.h"
#import "WriteContentViewController.h"
#import "DBModelViewsHeader.h"
#import "MyShareTextDetailCtr.h"

@interface MyShareViewController () <UITableViewDelegate, UITableViewDataSource, SlideButtonViewDelegate, ImageTypeCellDelegate>
{
    SlideButtonView *tSlideButtonView;
    NSMutableArray *dataArray;   //已发表
    NSMutableArray *dataArray1;  //未发表
    PublishType publishType;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation MyShareViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"写分享";
    
    kWEAKSELF;
    [weakSelf setRightBarButtonWithTitle:@"添加" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        WriteContentViewController *tWriteContentViewController = [[WriteContentViewController alloc] init];
        tWriteContentViewController.navTitle = @"写分享";
        tWriteContentViewController.contentType = WriteContentType_Share;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tWriteContentViewController];
        [weakSelf presentViewController:nav animated:YES completion:NULL];
    }];
    
    [self setSlideBtn];
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen screenWidth], [UIScreen screenHeight] - 40 - 64) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorColor = [UIColor clearColor];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mTableView];
    
    if (!dataArray) {
        dataArray = [[NSMutableArray alloc] init];
    }
    if (!dataArray1) {
        dataArray1 = [[NSMutableArray alloc] init];
    }
    
    publishType = PublishType_YES;
    [self setShareDataWithPublishTypy:PublishType_YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareDataNotification) name:kUserWriteShareSuccessNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SlideButtonViewDelegate
- (void)slideButtonAction:(UIButton *)sender {
    
    NSString *butTitle = sender.titleLabel.text;
    if ([butTitle isEqualToString:@"已发表"]) {
        
        publishType = PublishType_YES;
       
    } else if ([butTitle isEqualToString:@"未发表"]) {
        
        publishType = PublishType_NO;
       
    }
    
    [self setShareDataWithPublishTypy:publishType];
//    kWEAKSELF;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//       
//    });
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (publishType == PublishType_YES) {
         return dataArray.count;
    } else if (publishType == PublishType_NO) {
        return dataArray1.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 600.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyShareModel *model;
    if (publishType == PublishType_YES) {
        model = dataArray[indexPath.row];
    } else if (publishType == PublishType_NO) {
        model = dataArray1[indexPath.row];
    }
   
    if (model.shareType == ShareContentType_Image) {  //图片类型
        static NSString *ImageCellID = @"ImageCellID";
        ImageTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ImageCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTypeCell" owner:nil options:nil] lastObject];
            cell.delegate = self;
        }
        
        [cell setImageCellData:model];
        return cell;
        
    } else if (model.shareType == ShareContentType_Text) { //文本类型
        static NSString *TextCellID = @"TextCellID";
        TextTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextTypeCell" owner:nil options:nil] lastObject];
        }
        
        [cell setTextCellData:model];
        
        return cell;
        
    } else if (model.shareType == ShareContentType_Link) { //链接类型
        static NSString *LinkCellID = @"LinkCellID";
        LinkTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:LinkCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkTypeCell" owner:nil options:nil] lastObject];
        }
        
        return cell;
    } else {
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyShareModel *model;
    if (publishType == PublishType_YES) {
        model = dataArray[indexPath.row];
    } else if (publishType == PublishType_NO) {
        model = dataArray1[indexPath.row];
    }
    
    //当没有图片时，需要另做处理
    MyShareTextDetailCtr *tMyShareTextDetailCtr = [[MyShareTextDetailCtr alloc] init];
    tMyShareTextDetailCtr.content = model.content;
    tMyShareTextDetailCtr.imgAry = model.imgArr;
    tMyShareTextDetailCtr.shareId = model.id;
    tMyShareTextDetailCtr.isPublishTag = model.isPublishTag;
    [self.navigationController pushViewController:tMyShareTextDetailCtr animated:YES];
    
}

#pragma mark - ImageTypeCellDelegate 
- (void)tapImage:(UIImage *)img {
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.scanImage = img;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
}

#pragma mark - event responds 
- (void)shareDataNotification {
    [self setShareDataWithPublishTypy:publishType];
}

#pragma mark - setting and getting
- (void)setSlideBtn {
    NSArray *titleArray = @[@"已发表", @"未发表"];
    tSlideButtonView = [[SlideButtonView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40) btnArray:titleArray];
    tSlideButtonView.backgroundColor = [UIColor whiteColor];
    tSlideButtonView.delegate = self;
    [self.view addSubview:tSlideButtonView];
}

- (void)setShareDataWithPublishTypy:(PublishType)type {
    [SVProgressHUD show];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        if (type == PublishType_YES) {
            [dataArray removeAllObjects];
            [dataArray1 removeAllObjects];
            NSArray *shareAry = [MyShareViewModel findAllSharedDataWithPublishTag:PublishType_YES];
            [dataArray addObjectsFromArray:shareAry];
            
        } else if (type == PublishType_NO) {
            [dataArray removeAllObjects];
            [dataArray1 removeAllObjects];
            NSArray *shareAry = [MyShareViewModel findAllSharedDataWithPublishTag:PublishType_NO];
            [dataArray1 addObjectsFromArray:shareAry];
        }
       
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.mTableView reloadData];
    });
}

@end
