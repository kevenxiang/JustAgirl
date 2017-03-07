//
//  ConstellationCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/6.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ConstellationCtr.h"
#import "ConstellationCell.h"

@interface ConstellationCtr () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *titleArray;
    NSArray *imageArray;
    NSArray *nameArray;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ConstellationCtr

static NSString * const reuseIdentifier = @"ConstellationCell";

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"星座";
    
    titleArray = @[@"3.21-4.19", @"4.20-5.20", @"5.21-6.21", @"6.22-7.22", @"7.23-8.22", @"8.23-9.22", @"9.23-10.23", @"10.24-11.22", @"11.23-12.21", @"12.22-1.19", @"1.20-2.18", @"2.19-3.20"];
    imageArray = @[@"baiyang", @"jinniu", @"shuangzi", @"juxie", @"shizi", @"chunv", @"tianping", @"tianxie", @"sheshou",  @"moxie", @"shuiping", @"shuangyu"];
    nameArray = @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座", @"水瓶座", @"双鱼座"];
    
    [self addMainUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ConstellationCell *cell=(ConstellationCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:imageArray[indexPath.item]];
    cell.titleLabel.text = titleArray[indexPath.item];
    cell.xinLable.text = nameArray[indexPath.item];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - getting and setting
- (void)addMainUI {
    UICollectionViewFlowLayout *mLayout = [[UICollectionViewFlowLayout alloc] init];
    mLayout.itemSize = CGSizeMake([UIScreen screenWidth]/2 - 40, 120);
    mLayout.minimumLineSpacing = 12;
    mLayout.minimumInteritemSpacing = 2;
    mLayout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], kScreenHeight - 64) collectionViewLayout:mLayout];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"skynight"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    
    UINib *nib = [UINib nibWithNibName:@"ConstellationCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}


@end
