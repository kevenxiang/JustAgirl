//
//  MenstruationDateCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/6.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MenstruationDateCtr.h"
#import "MenstruationDateColleCell.h"

@interface MenstruationDateCtr () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MenstruationDateCtr

static NSString * const reuseIdentifier = @"MenstruationDateColleCell";

#pragma mark - lify cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"例假周期";
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, 36, 22);
    [rightBarButton setTitle:@"添加" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton addActionHandler:^(NSInteger tag) {
        
    }];
    
    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton1.frame = CGRectMake(0, 0, 36, 22);
    [rightBarButton1 setTitle:@"预测" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton1 addActionHandler:^(NSInteger tag) {
        
    }];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *rItem1 = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton1];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem1,rItem, nil];
    
    
    [self addMainUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenstruationDateColleCell *cell=(MenstruationDateColleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
   
}

#pragma mark - getting and setting
- (void)addMainUI {
    UICollectionViewFlowLayout *mLayout = [[UICollectionViewFlowLayout alloc] init];
    mLayout.itemSize = CGSizeMake([UIScreen screenWidth]/2 - 40, 100);
    mLayout.minimumLineSpacing = 12;
    mLayout.minimumInteritemSpacing = 2;
    mLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen screenWidth], [UIScreen screenHeight]) collectionViewLayout:mLayout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    
    UINib *nib = [UINib nibWithNibName:@"MenstruationDateColleCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}


@end
