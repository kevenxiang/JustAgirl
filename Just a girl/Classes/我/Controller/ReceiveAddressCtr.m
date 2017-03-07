//
//  ReceiveAddressCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ReceiveAddressCtr.h"
#import "MyReceiveAddressCell.h"
#import "AddNewReceivePeopleCtr.h"


//数据库处理层
#import "DBModelViewsHeader.h"

@interface ReceiveAddressCtr () <UITableViewDelegate, UITableViewDataSource, AddNewReceivePeopleCtrDelegate, MyReceiveAddressCellDelegate>
{
    NSMutableArray *dataAry;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ReceiveAddressCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的收货地址";
    
    dataAry = [[NSMutableArray alloc] init];
    [self findAddrData];
    self.mTableView.rowHeight = 130.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 130.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *tView = [[UIView alloc] init];
        tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
        tView.backgroundColor = [UIColor clearColor];
        return tView;
    } else {
        UIView *tView = [[UIView alloc] init];
        tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
        tView.backgroundColor = [UIColor clearColor];
        return tView;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *tView = [[UIView alloc] init];
    tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
    tView.backgroundColor = [UIColor clearColor];
    return tView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceiveAddressModel *model = dataAry[indexPath.section];
    static NSString *CellID = @"CellID";
    MyReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyReceiveAddressCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexRow = indexPath.section;
        cell.delegate = self;
    }
    
    [cell setData:model];
    return cell;
}

#pragma mark - AddNewReceivePeopleCtrDelegate
- (void)refreshReceiveData {
    [self findAddrData];
}

#pragma mark - MyReceiveAddressCellDelegate
- (void)isDefaultBtnAction:(NSInteger)indexRow {
    
    ReceiveAddressModel *selectModel = dataAry[indexRow];
    if (selectModel.isDefaultAddress == 1) {
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSArray *addrArr = [ReceiveAddressModelView findAllAddress];
        for (NSInteger i = 0; i < addrArr.count; i++) {
            ReceiveAddressModel *model = addrArr[i];
            model.isDefaultAddress = 0;
            [model update];
        }
        
        ReceiveAddressModel *model = dataAry[indexRow];
        model.isDefaultAddress = 1;
        [model update];
        
        [dataAry removeAllObjects];
        NSArray *arr = [ReceiveAddressModelView findAllAddress];
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSMutableArray *b = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < arr.count; i++) {
            ReceiveAddressModel *model = arr[i];
            if (model.isDefaultAddress == 1) {
                [a addObject:model];
            } else {
                [b addObject:model];
            }
            
        }
        [dataAry addObjectsFromArray:a];
        [dataAry addObjectsFromArray:b];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
   
        [self.mTableView reloadData];
        [self.mTableView moveSection:indexRow toSection:0];
        
    });
}

- (void)editBtnAction:(NSInteger)indexRow {
    ReceiveAddressModel *model = dataAry[indexRow];
    AddNewReceivePeopleCtr *tAddNewReceivePeopleCtr = [[AddNewReceivePeopleCtr alloc] init];
    tAddNewReceivePeopleCtr.delegate = self;
    tAddNewReceivePeopleCtr.editTag = 1;
    tAddNewReceivePeopleCtr.model = model;
    [self.navigationController pushViewController:tAddNewReceivePeopleCtr animated:YES];
}

- (void)deleteBtnAction:(NSInteger)indexRow {
    ReceiveAddressModel *model = dataAry[indexRow];
    [model deleteObject];
    [dataAry removeObjectAtIndex:indexRow];
    [self.mTableView reloadData];
}

#pragma mark - event responds
- (IBAction)addNewRecieveAddressAction:(id)sender {
    AddNewReceivePeopleCtr *tAddNewReceivePeopleCtr = [[AddNewReceivePeopleCtr alloc] init];
    tAddNewReceivePeopleCtr.delegate = self;
    [self.navigationController pushViewController:tAddNewReceivePeopleCtr animated:YES];
}


#pragma mark - gettings and settings
- (void)findAddrData {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_TARGET_QUEUE_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [dataAry removeAllObjects];
        NSArray *arr = [ReceiveAddressModelView findAllAddress];
        NSMutableArray *a = [[NSMutableArray alloc] init];
        NSMutableArray *b = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < arr.count; i++) {
            ReceiveAddressModel *model = arr[i];
            if (model.isDefaultAddress == 1) {
                [a addObject:model];
            } else {
                [b addObject:model];
            }
            
        }
        [dataAry addObjectsFromArray:a];
        [dataAry addObjectsFromArray:b];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.mTableView reloadData];
    });
}

@end
