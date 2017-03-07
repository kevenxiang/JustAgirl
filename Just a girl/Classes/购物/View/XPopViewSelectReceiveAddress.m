//
//  XPopViewSelectReceiveAddress.m
//  Just a girl
//
//  Created by xiang on 2016/11/15.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "XPopViewSelectReceiveAddress.h"
#import "ReceiveAddressModelView.h"
#import "DefineConfig.h"

@interface XPopViewSelectReceiveAddress () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mTableView;
    NSMutableArray *dataAry;
}

@property (nonatomic, strong) UIButton *selectOtherAddressBtn;

@end

@implementation XPopViewSelectReceiveAddress

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initTable];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTable];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    mTableView.frame = CGRectMake(0, 36, self.bounds.size.width, self.bounds.size.height - 36 - 50);
    self.selectOtherAddressBtn.frame = CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 50.0f);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceiveAddressModel *model = dataAry[indexPath.row];
    
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@", model.userName, model.userPhone];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", model.userArea, model.userAddress];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - event responds
- (void)selectOtherAddressBtnAction {

}

#pragma mark - getting and setting
- (void)initTable {
    if (!mTableView) {
        mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, 80) style:UITableViewStylePlain];
        mTableView.tableFooterView = [[UIView alloc] init];
        mTableView.delegate = self;
        mTableView.dataSource = self;
        [self addSubview:mTableView];
        
        if (!self.selectOtherAddressBtn) {
            self.selectOtherAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.selectOtherAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.selectOtherAddressBtn setBackgroundColor:kThemeColor];
            [self.selectOtherAddressBtn setTitle:@"选择其他地址" forState:UIControlStateNormal];
            [self.selectOtherAddressBtn addTarget:self action:@selector(selectOtherAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.selectOtherAddressBtn];
        }
        
        if (!dataAry) {
            dataAry = [[NSMutableArray alloc] init];
        }
    }
}

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
        [mTableView reloadData];
    });
}


@end
