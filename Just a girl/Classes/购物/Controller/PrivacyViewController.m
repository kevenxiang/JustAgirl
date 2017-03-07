//
//  PrivacyViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "PrivacyViewController.h"
#import "ContentCollectionViewCell.h"
#import "FocusCollectionViewLayout.h"
#import "ASFSharedViewTransition.h"
#import "PrivacyDetailViewController.h"
#import "ProductDetailCtr.h"

@interface PrivacyViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ASFSharedViewTransitionDataSource>
{
    UICollectionView *_collectionView;
    FocusCollectionViewLayout *_hanabiCollectionViewLayout;
}

@end

@implementation PrivacyViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.pushTag == 1) {
        self.navigationItem.title = @"我的关注";
    } else {
        self.navigationItem.title = @"购物";
        kWEAKSELF;
        [self setRightBarButtonWithTitle:@"已关注" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
            PrivacyViewController *privacy = [[PrivacyViewController alloc] init];
            privacy.hidesBottomBarWhenPushed = YES;
            privacy.pushTag = 1;
            [weakSelf.navigationController pushViewController:privacy animated:YES];
        }];
    }
    
    // Add Transition
    [ASFSharedViewTransition addTransitionWithFromViewControllerClass:[PrivacyViewController class]
                                                ToViewControllerClass:[ProductDetailCtr class]
                                             WithNavigationController:(UINavigationController *)self.navigationController
                                                         WithDuration:0.3f];

    
    _hanabiCollectionViewLayout = [[FocusCollectionViewLayout alloc] init];
    [_hanabiCollectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [_hanabiCollectionViewLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:_hanabiCollectionViewLayout];
    [_collectionView registerNib:[UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.view addSubview:_collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    cell.bgImgView.image = [self imageAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了============:%ld", indexPath.item);
    
//    PrivacyDetailViewController *detailVC = [[PrivacyDetailViewController alloc] init];
//    detailVC.topImg = [self imageAtIndex:indexPath.item];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    ProductDetailCtr *detail = [[ProductDetailCtr alloc] init];
    detail.topImg = [self imageAtIndex:indexPath.item];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - ASFSharedViewTransitionDataSource
- (UIView *)sharedView {
    return [_collectionView cellForItemAtIndexPath:[[_collectionView indexPathsForSelectedItems] firstObject]];
}

#pragma mark - private methods
- (UIImage *)imageAtIndex:(NSInteger)index {
    return [UIImage imageNamed:[NSString stringWithFormat:@"background-%li.jpg",(index + 1)]];
}


@end
