//
//  MyShareDetailCtr.m
//  Just a girl
//
//  Created by xiang on 2016/10/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyShareTextDetailCtr.h"
#import "MyShareImageDetailCtr.h"

#import "UILabel+SuggestSize.h"
#import "UIScrollView+JYPaging.h"

@interface MyShareTextDetailCtr ()
{
    UIButton *rightBarButton;
    NSInteger imageIndex;
}
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MyShareTextDetailCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageIndex = 0;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"分享详情";
    
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.contentLabel];
    
    [self.contentLabel setText:self.content];
    CGFloat contentLabelHeight = [self.contentLabel suggestSizeForString:self.content width:[UIScreen mainScreen].bounds.size.width - 20].height;
    CGRect frame = self.contentLabel.frame;
    frame.size.height = contentLabelHeight;
    self.contentLabel.frame = frame;
    self.bgScrollView.contentSize = CGSizeMake(0, contentLabelHeight + 100);
    
    
    if (self.imgAry.length > 0) {//有图片
        MyShareImageDetailCtr *imageDetailVC = [[MyShareImageDetailCtr alloc] init];
        imageDetailVC.imgAry = self.imgAry;
        [self addChildViewController:imageDetailVC];
        
        if (imageDetailVC.view != nil) {
            self.bgScrollView.secondScrollView = imageDetailVC.bgScrollView;
            self.bgScrollView.scrollType = kShowDetailScrollType_MyShareDetail;
        }
        
        
        rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
        rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
        if (self.isPublishTag == 1) {
            
        } else {
            [rightBarButton setTitle:@"发表" forState:UIControlStateNormal];
        }
        
        [rightBarButton setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [rightBarButton addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = kRightMargin;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem, space, nil];
        
        //安装上拉的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kJYPadingUpLoadNotification) name:@"kJYPadingUpLoadNotification" object:nil];
        //安装下拉的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kJYPadingDownLoadNotification) name:@"kJYPadingDownLoadNotification" object:nil];
        //安装拖动图片的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kIndexImageNotification:) name:@"kIndexImageNotification" object:nil];
    } else { //没有图片
        kWEAKSELF;
        [self setRightBarButtonWithTitle:@"发表" titleColor:kThemeColor withBlock:^(NSInteger tag) {
            if ([MyShareViewModel updateMyShareToPublishWithId:weakSelf.shareId]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.view makeToast:@"发表成功" duration:3.0 position:@"top"];
                });
            }
        }];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - event responds
- (void)kJYPadingUpLoadNotification {
 
    rightBarButton.alpha = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         NSArray *imageArray = [self.imgAry componentsSeparatedByString:@","];
        if (imageIndex == 0) {
            [rightBarButton setTitle:[NSString stringWithFormat:@"%ld", imageArray.count] forState:UIControlStateNormal];
        } else {
            [rightBarButton setTitle:[NSString stringWithFormat:@"%ld", imageArray.count - imageIndex] forState:UIControlStateNormal];
        }
    });
   
}

- (void)kJYPadingDownLoadNotification {
    if (self.isPublishTag == 1) {
        rightBarButton.alpha = 0;
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [rightBarButton setTitle:@"发表" forState:UIControlStateNormal];
        });
    }
   
}

- (void)kIndexImageNotification:(NSNotification *)info {
    
    NSDictionary *tDic = [info userInfo];
    NSInteger index = [[tDic objectForKey:@"indexKey"] integerValue];
    imageIndex = index;
    NSArray *imageArray = [self.imgAry componentsSeparatedByString:@","];
    [rightBarButton setTitle:[NSString stringWithFormat:@"%ld", imageArray.count - imageIndex] forState:UIControlStateNormal];
}

- (void)rightBarButtonAction:(UIButton *)sender {
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"发表"]) {
        if ([MyShareViewModel updateMyShareToPublishWithId:self.shareId]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.65 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.view makeToast:@"发表成功" duration:3.0 position:@"top"];
            });
        }
    }
    
}

#pragma mark - gettings and settings
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 0);
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor darkTextColor];
    }
    
    return _contentLabel;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.userInteractionEnabled = YES;
    }
    
    return _bgScrollView;
}

@end
