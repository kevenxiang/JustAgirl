//
//  WriteDiaryViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/23.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "WriteDiaryViewController.h"
#import "WriteContentViewController.h"
#import "DiaryTitleCell.h"
#import "DiaryViewModel.h"
#import "ScanWriteContentCtr.h"

@interface WriteDiaryViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSString *dateTitle;
    NSMutableArray *dataArray;//保存某天的日记信息
}

@property (strong, nonatomic) NSMutableDictionary *fillDefaultColors;
@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation WriteDiaryViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的日记";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateTitle = [dateFormatter stringFromDate:[NSDate date]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    dataArray = [[NSMutableArray alloc] init];
    [self setDiaryData];
    
    //如果某个日期写了日记，就填充颜色
    if (!self.fillDefaultColors) {
        self.fillDefaultColors = [[NSMutableDictionary alloc] init];
    }
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *allData = [DiaryViewModel findAllData];
        for (NSInteger i = 0; i < allData.count; i++) {
            DiaryModel *model = allData[i];
            [self.fillDefaultColors setObject:[UIColor magentaColor] forKey:model.createTime];
        }
    });
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;

    CGFloat height = 240;
    FSCalendar* calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    calendar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    [self.view addSubview:calendar];
    [calendar selectDate:[NSDate date]];
    self.calendar = calendar;
    
    kWEAKSELF;
    [self setRightBarButtonWithTitle:@"回今天" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        
        [calendar selectDate:[NSDate date]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateTitle = [dateFormatter stringFromDate:[NSDate date]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [weakSelf.mTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         [weakSelf setDiaryData];

    }];
    
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height, [UIScreen screenWidth], kScreenHeight - height - 45 - 64) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.backgroundColor = [UIColor clearColor];
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.mTableView];
    
    CGFloat startY = kScreenHeight - 45 - 64;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, startY, [UIScreen screenWidth], 45)];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bottomView];
    
    UIButton *writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    writeBtn.frame = CGRectMake(0, 0, bottomView.frame.size.width, bottomView.frame.size.height);
    writeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [writeBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [writeBtn setTitle:@"➕写日记" forState:UIControlStateNormal];
    [writeBtn addTarget:self action:@selector(writeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:writeBtn];
    
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
    return dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 44.0f;
    } else {
        return 60.0f;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *CellID = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        
        cell.textLabel.text = dateTitle;
        
        return cell;

    } else {
        static NSString *DirayCellID = @"DirayCellID";
        DiaryTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:DirayCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DiaryTitleCell" owner:nil options:nil] lastObject];
        }
        
        DiaryModel *model = dataArray[indexPath.row - 1];
        [cell setData:model];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    } else {
        DiaryModel *model = dataArray[indexPath.row - 1];
        ScanWriteContentCtr *tScanWriteContentCtr = [[ScanWriteContentCtr alloc] init];
        tScanWriteContentCtr.contentType = WriteContentType_Diary;
        tScanWriteContentCtr.diary = model;
        [self.navigationController pushViewController:tScanWriteContentCtr animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _mTableView) {
        CGFloat offset = scrollView.contentOffset.y;
        NSLog(@"=======offset==:%f", offset);
        if (offset > 80) {
            [UIView animateWithDuration:0.35 animations:^{
                [self.calendar setScope:FSCalendarScopeWeek animated:YES];
            } completion:^(BOOL finished) {
                self.mTableView.frame = CGRectMake(0, 90, kScreenWidth, kScreenHeight - 90 - 45 - 64);
            }];
        }
        
        if (offset < -80) {
            [UIView animateWithDuration:0.35 animations:^{
                [self.calendar setScope:FSCalendarScopeMonth animated:YES];
            }completion:^(BOOL finished) {
                self.mTableView.frame = CGRectMake(0, 240, kScreenWidth, kScreenHeight - 240 - 45 - 64);
            }];
            
        }

    }
   
}

#pragma mark - FSCalendarDelegateAppearance
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    NSString *key = [_calendar stringFromDate:date format:@"yyyy-MM-dd"];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    _calendar.frame = CGRectMake(_calendar.frame.origin.x, _calendar.frame.origin.y, _calendar.frame.size.width, CGRectGetHeight(bounds));
    [self.view layoutIfNeeded];
}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    NSLog(@"选中的日期:%@", date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateTitle = [dateFormatter stringFromDate:date];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.mTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     NSLog(@"选中的日期====dateTitle:%@", dateTitle);
    [self setDiaryData];
}

#pragma mark - event responds
- (void)writeBtnAction:(id)sender {
    WriteContentViewController *tWriteContentViewController = [[WriteContentViewController alloc] init];
    tWriteContentViewController.navTitle = dateTitle;
    tWriteContentViewController.contentType = WriteContentType_Diary;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tWriteContentViewController];
    [self presentViewController:nav animated:YES completion:NULL];
}

#pragma mark - gettings and settings
- (void)setDiaryData {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [dataArray removeAllObjects];
        NSArray *dairyAry = [DiaryViewModel findDiaryWithCreateTime:dateTitle];
        [dataArray addObjectsFromArray:dairyAry];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.mTableView reloadData];
    });
}

@end
