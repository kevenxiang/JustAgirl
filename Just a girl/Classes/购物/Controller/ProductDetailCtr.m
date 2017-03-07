//
//  ProductDetailCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/11.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ProductDetailCtr.h"
#import "ScanImageViewController.h"
#import "ShoppingCartCtr.h"

#import "ASFSharedViewTransition.h"
#import "XPopView.h"
#import "XPopViewSelectProduct.h"
#import "XPopViewSelectReceiveAddress.h"
#import "PackAndAfterSale.h"

#import "ProductTitleCell.h"
#import "ProductInfoCell.h"
#import "ReceiveAddressCell.h"
#import "EvaluateTitleCell.h"
#import "CommentImageCell.h"
#import "CommentTextCell.h"



#define MAINSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define IMAGESCROVIEWHIGHT 240.0 //轮播图高度
#define kBottomViewHeight  50

@interface ProductDetailCtr () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, XPopViewDelegate>
{
    UIButton *colloctBtn;
    UIButton *careBtn;
    UIButton *buyCarBtn;
    UIButton *joinCarBtn;
}

@property (nonatomic, strong) UIScrollView * scroViewBG;
@property (nonatomic, strong) UIScrollView * scroViewImage;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ProductDetailCtr
@synthesize numLabel;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addMainUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *tView = [[UIView alloc] init];
    tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
    tView.backgroundColor = [UIColor clearColor];
    return tView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *tView = [[UIView alloc] init];
    tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
    tView.backgroundColor = [UIColor clearColor];
    return tView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 3) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100.0f;
        } else if (indexPath.row == 1) {
            return 44.0f;
        } else if (indexPath.row == 2) {
            return 44.0f;
        }
    } else if (indexPath.section == 1) {
        return 44.0f;
    } else if (indexPath.section == 2) {
        return 110.0f;
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 44.0f;
        } else if (indexPath.row == 1) {
            return 380.0f;
        } else if (indexPath.row == 2) {
            return 240.0f;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *ProductTitleCellID = @"ProductTitleCellID";
            ProductTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTitleCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductTitleCell" owner:nil options:nil] lastObject];
            }
            
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *ProductIntroduceCellID = @"ProductIntroduceCellID";
            ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductIntroduceCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductInfoCell" owner:nil options:nil] lastObject];
            }
            
            cell.titleLabel.text = @"商品介绍 (建议在WiFi环境下查看)";
            
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *ProductPackCellID = @"ProductPackCellID";
            ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductPackCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductInfoCell" owner:nil options:nil] lastObject];
            }
            cell.titleLabel.text = @"包装售后";
            return cell;
        }
    } else if (indexPath.section == 1) {
        static NSString *ProductNumCellID = @"ProductNumCellID";
        ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductNumCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductInfoCell" owner:nil options:nil] lastObject];
        }
        NSString *str = @"已选\t深蓝色，1个";
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr addAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} range:NSMakeRange(0, 2)];
        cell.titleLabel.attributedText = attriStr;
        return cell;
    } else if (indexPath.section == 2) {
        static NSString *ReceiveAddressCellID = @"ReceiveAddressCellID";
        ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ReceiveAddressCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReceiveAddressCell" owner:nil options:nil] lastObject];
        }
        
        return cell;
    } else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            
            static NSString *EvaluateTitleCellID = @"EvaluateTitleCellID";
            EvaluateTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:EvaluateTitleCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EvaluateTitleCell" owner:nil options:nil] lastObject];
            }
            
            return cell;
            
        } else if (indexPath.row == 1) {
            
            static NSString *CommentImageCellID = @"CommentImageCellID";
            CommentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentImageCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentImageCell" owner:nil options:nil] lastObject];
            }
            
            return cell;
            
        } else if (indexPath.row == 2) {
        
            static NSString *CommentTextCellID = @"CommentTextCellID";
            CommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTextCellID];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextCell" owner:nil options:nil] lastObject];
            }
            
            return cell;
        }
        
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"2222222222222222";
    cell.textLabel.textColor = [UIColor magentaColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 && indexPath.section == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/1000.0f;
            transform = CATransform3DRotate(transform, M_PI_4/3, 0.1, 0, 0);
            self.view.layer.transform = transform;
        } completion:^(BOOL finished) {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -4.5/2000.0f;
            transform = CATransform3DScale(transform, 0.9, 0.9, 0.9);
            self.view.layer.transform = transform;
            
            PackAndAfterSale *popView = [[PackAndAfterSale alloc] init];
            popView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 180);
            popView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self.view addSubview:popView];
            popView.delegate = self;
            [popView pop];
            
        }];

    }
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/1000.0f;
            transform = CATransform3DRotate(transform, M_PI_4/3, 0.1, 0, 0);
            self.view.layer.transform = transform;
        } completion:^(BOOL finished) {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -4.5/2000.0f;
            transform = CATransform3DScale(transform, 0.9, 0.9, 0.9);
            self.view.layer.transform = transform;
            
            XPopViewSelectProduct *popView = [[XPopViewSelectProduct alloc] init];
            popView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 120);
            [self.view addSubview:popView];
            popView.delegate = self;
            [popView pop];
            
        }];

    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -1.0/1000.0f;
            transform = CATransform3DRotate(transform, M_PI_4/3, 0.1, 0, 0);
            self.view.layer.transform = transform;
        } completion:^(BOOL finished) {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = -4.5/2000.0f;
            transform = CATransform3DScale(transform, 0.9, 0.9, 0.9);
            self.view.layer.transform = transform;
            
            XPopViewSelectReceiveAddress *popView = [[XPopViewSelectReceiveAddress alloc] init];
            popView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            popView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 180);
            [popView findAddrData];
            [self.view addSubview:popView];
            popView.delegate = self;
            [popView pop];
            
        }];

    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scroViewImage) {
        NSInteger offX = (NSInteger)scrollView.contentOffset.x / MAINSCREENWIDTH;
        numLabel.text = [NSString stringWithFormat:@"%ld/5", offX + 1];
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.scroViewImage) {
        [self.topImgView removeFromSuperview];
        self.topImgView = nil;
        for (NSInteger i = 0; i < 5; i++) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREENWIDTH * i, 0, MAINSCREENWIDTH, IMAGESCROVIEWHIGHT)];
            image.image = [UIImage imageNamed:[NSString stringWithFormat:@"background-%li.jpg",(i + 1)]];
            [self.scroViewImage addSubview:image];
            image.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction:)];
            imgTap.numberOfTapsRequired = 1;
            [image addGestureRecognizer:imgTap];
        }
    }
}

#pragma mark - ASFSharedViewTransitionDataSource
- (UIView *)sharedView {
    return _topImgView;
}

#pragma mark - XPopViewDelegate
- (void)dismissDelegate {
    [UIView animateWithDuration:0.25 animations:^{
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = 0;
        transform = CATransform3DRotate(transform, 0, 0, 0, 0);
        self.view.layer.transform = transform;
    }];
}

#pragma mark - event responds
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.tableView.contentOffset.y >= 0) {
        self.scroViewImage.layer.position = CGPointMake(self.scroViewImage.layer.position.x, (IMAGESCROVIEWHIGHT + self.tableView.contentOffset.y) * 0.5);
    }
}

- (void)backC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imgTapAction:(UITapGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.hidesBottomBarWhenPushed = YES;
    scanImageCtr.scanImage = imgView.image;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
}

//收藏
- (void)colloctBtnAction:(id)sender {

}

//关注
- (void)careBtnAction:(id)sender {

}

//购物车
- (void)buyCarBtnAction:(id)sender {
    ShoppingCartCtr *tShoppingCartCtr = [[ShoppingCartCtr alloc] init];
    [self.navigationController pushViewController:tShoppingCartCtr animated:YES];
}

//加入购物车
- (void)joinCarBtnAction:(id)sender {

}

#pragma mark - private methods
- (void)setupNavBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTopAttached barMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (UIImage *)imageWithBgColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - getting and setting
- (void)addMainUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight] - 50) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.scroViewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, IMAGESCROVIEWHIGHT)];
    self.scroViewBG.contentSize = CGSizeMake(0, 0);
    self.scroViewBG.contentOffset = CGPointZero;
    self.tableView.tableHeaderView = self.scroViewBG;
    
    self.scroViewImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, IMAGESCROVIEWHIGHT)];
    self.scroViewImage.backgroundColor = [UIColor whiteColor];
    self.scroViewImage.contentSize = CGSizeMake(MAINSCREENWIDTH * 5, 0);
    self.scroViewImage.showsVerticalScrollIndicator = NO;
    self.scroViewImage.showsHorizontalScrollIndicator = NO;
    self.scroViewImage.pagingEnabled = YES;
    self.scroViewImage.delegate = self;
    [self.scroViewBG addSubview:self.scroViewImage];
    
    numLabel = [[UILabel alloc] init];
    numLabel.frame = CGRectMake([UIScreen screenWidth] - (40 + 10), IMAGESCROVIEWHIGHT - 60, 40, 40);
    numLabel.textColor = [UIColor whiteColor];
    numLabel.text = @"1/5";
    numLabel.font = [UIFont boldSystemFontOfSize:16];
    numLabel.layer.cornerRadius = 20;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
    numLabel.layer.borderWidth = 1.5;
    [self.scroViewBG addSubview:numLabel];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    self.topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, IMAGESCROVIEWHIGHT)];
    self.topImgView.image = self.topImg;
    self.topImgView.userInteractionEnabled = YES;
    [self.scroViewImage addSubview:self.topImgView];
    
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction:)];
    imgTap.numberOfTapsRequired = 1;
    [self.topImgView addGestureRecognizer:imgTap];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(12, (64-24)/2 + 8, 24, 24);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    _bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(0, [UIScreen screenHeight] - kBottomViewHeight, [UIScreen screenWidth], kBottomViewHeight);
    self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.bottomView];
    
    colloctBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colloctBtn.frame = CGRectMake(0, 0, self.bottomView.frame.size.width * 1/5, kBottomViewHeight);
    [colloctBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [colloctBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [colloctBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [colloctBtn addTarget:self action:@selector(colloctBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:colloctBtn];
    
    UIView *collectLine = [[UIView alloc] init];
    collectLine.backgroundColor = [UIColor lightGrayColor];
    collectLine.frame = CGRectMake(self.bottomView.frame.size.width * 1/5, 0, 1, kBottomViewHeight);
    [self.bottomView addSubview:collectLine];
    
    careBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    careBtn.frame = CGRectMake(self.bottomView.frame.size.width * 1/5, 0, self.bottomView.frame.size.width * 1/5, kBottomViewHeight);
    [careBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [careBtn setTitle:@"关注" forState:UIControlStateNormal];
    [careBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [careBtn addTarget:self action:@selector(careBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:careBtn];
    
    UIView *careLine = [[UIView alloc] init];
    careLine.backgroundColor = [UIColor lightGrayColor];
    careLine.frame = CGRectMake(self.bottomView.frame.size.width * 2/5, 0, 1, kBottomViewHeight);
    [self.bottomView addSubview:careLine];
    
    buyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCarBtn.frame = CGRectMake(self.bottomView.frame.size.width * 2/5, 0, self.bottomView.frame.size.width * 1/5, kBottomViewHeight);
    [buyCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buyCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [buyCarBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [buyCarBtn addTarget:self action:@selector(buyCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buyCarBtn];
    
    UIView *buyCarLine = [[UIView alloc] init];
    buyCarLine.backgroundColor = [UIColor lightGrayColor];
    buyCarLine.frame = CGRectMake(self.bottomView.frame.size.width * 3/5, 0, 1, kBottomViewHeight);
    [self.bottomView addSubview:buyCarLine];
    
    joinCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinCarBtn.frame = CGRectMake(self.bottomView.frame.size.width * 3/5, 0, self.bottomView.frame.size.width * 2/5, kBottomViewHeight);
    [joinCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [joinCarBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [joinCarBtn setBackgroundColor:kThemeColor];
    [joinCarBtn addTarget:self action:@selector(joinCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:joinCarBtn];
    
}

@end

