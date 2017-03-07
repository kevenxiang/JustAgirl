//
//  ShoppingCartCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ShoppingCartCtr.h"
#import "ShoppingCartCell.h"

#define kCellSelectedTag     1
#define kCellUnSelectTag     0

@interface ShoppingCartCtr () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger selectTag;
    UIButton *rightBtn;
    NSArray *data;
    //cell是否被选择的记录字典
    NSMutableDictionary *cellSelectDic;
    BOOL isSelectCell;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIView *calculateView;
@property (weak, nonatomic) IBOutlet UIButton *calculateBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *allSelect;

@end

@implementation ShoppingCartCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购物车";
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 40);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kRightMargin;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space,rItem, nil];
    
    self.calculateBtn.layer.cornerRadius = 5;
    self.calculateBtn.layer.masksToBounds = YES;
    self.deleteBtn.layer.cornerRadius = 5;
    self.deleteBtn.layer.masksToBounds = YES;
    self.collectBtn.layer.cornerRadius = 5;
    self.collectBtn.layer.masksToBounds = YES;
    
    data = @[@"2", @"we", @"ertt",@"2333", @"w565e", @"ersdddftt"];
    //cell是否被选择的记录字典
    cellSelectDic = [[NSMutableDictionary alloc] init];
    //默认全部不选中
    for (NSInteger i = 0; i < data.count; i++) {
        NSString *key = [NSString stringWithFormat:@"%ld",i];
        [cellSelectDic setObject:[NSNumber numberWithInt:kCellUnSelectTag] forKey:key];
    }
    
}

- (void)rightBtnAction {
    if (selectTag == 1) {
        selectTag = 0;
        isSelectCell = NO;
       [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.calculateView.hidden = NO;
        self.editView.hidden = YES;
    } else {
        selectTag = 1;
        isSelectCell = YES;
        [cellSelectDic removeAllObjects];
        [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.calculateView.hidden = YES;
        self.editView.hidden = NO;
        [self.allSelect setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
    }
    
    [self.mTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ShoppingCellID = @"ShoppingCellID";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCellID];
    if (cell == nil) {
        cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShoppingCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData];
    }
    
    if (selectTag == 1) {
        [cell selectWithTag:YES];
    } else {
        [cell selectWithTag:NO];
    }
    
    int cellSelectTag = [[cellSelectDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] intValue];
    [cell cellIsSelect:cellSelectTag];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (isSelectCell) {
        NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
        int cellSelectTag = [[cellSelectDic objectForKey:key] intValue];
        if (cellSelectTag == kCellUnSelectTag) {
            [cellSelectDic setObject:[NSNumber numberWithInt:kCellSelectedTag] forKey:key];
        } else {
            [cellSelectDic setObject:[NSNumber numberWithInt:kCellUnSelectTag] forKey:key];
        }
        [self judgeIsAllSelected];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - event responds
- (IBAction)allSelect:(id)sender {
    
    NSMutableArray *allSelectArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < cellSelectDic.allValues.count; i++) {
        NSString *value = cellSelectDic.allValues[i];
        if (value.integerValue == kCellSelectedTag) {
            [allSelectArr addObject:[NSNumber numberWithInt:kCellSelectedTag]];
        }
    }
    
    if (allSelectArr.count == data.count) {
        [self.allSelect setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
        for (NSInteger i = 0; i < data.count; i++) {
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            [cellSelectDic setObject:[NSNumber numberWithInt:kCellUnSelectTag] forKey:key];
        }
    } else {
        [self.allSelect setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
        for (NSInteger i = 0; i < data.count; i++) {
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            [cellSelectDic setObject:[NSNumber numberWithInt:kCellSelectedTag] forKey:key];
        }
    }
    
    
    [self.mTableView reloadData];
}

- (IBAction)collectBtnAction:(id)sender {
    for (NSInteger i = 0; i < cellSelectDic.allValues.count; i++) {
        NSInteger key = [cellSelectDic.allKeys[i] integerValue];
        NSString *value = cellSelectDic.allValues[i];
        if (value.integerValue == kCellSelectedTag) {
            NSString *selectData = data[key];
            NSLog(@"选中的cell:%ld, 选中的数据:%@", key, selectData);
        }
    }

}

#pragma mark - private methods
- (void)judgeIsAllSelected {
    NSMutableArray *allSelectArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < cellSelectDic.allValues.count; i++) {
        NSString *value = cellSelectDic.allValues[i];
        if (value.integerValue == kCellSelectedTag) {
            [allSelectArr addObject:[NSNumber numberWithInt:kCellSelectedTag]];
        }
    }
    
    if (allSelectArr.count == data.count) {
        [self.allSelect setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    } else {
        [self.allSelect setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
        
    }

}


@end
