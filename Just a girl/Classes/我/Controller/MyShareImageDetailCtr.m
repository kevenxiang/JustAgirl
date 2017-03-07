//
//  MyShareImageDetailCtr.m
//  Just a girl
//
//  Created by xiang on 2016/10/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyShareImageDetailCtr.h"

@interface MyShareImageDetailCtr () <UIScrollViewDelegate>
{
    UIButton *rightBarButton;
}

@end

@implementation MyShareImageDetailCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    [self.view addSubview:self.bgScrollView];
    
    NSArray *imageArray = [self.imgAry componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        NSData *imageData = [FCFileManager readFileAtPathAsData:imageArray[i]];
        UIImage *image = [UIImage imageWithData:imageData];
        imgView.image = image;
        
        imgView.tag = 100 + i;
        imgView.userInteractionEnabled = YES;
        [self.bgScrollView addSubview:imgView];
        
    }
    
    
    self.bgScrollView.contentSize = CGSizeMake(imageArray.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
   
    //发送拖动图片的通知
    NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
    [tDic setObject:@(index) forKey:@"indexKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kIndexImageNotification" object:nil userInfo:tDic];
}

#pragma mark - gettings and settings
- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _bgScrollView.backgroundColor = [UIColor blackColor];
        _bgScrollView.delegate = self;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.directionalLockEnabled = YES;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.userInteractionEnabled = YES;
    }
    
    return _bgScrollView;
}

@end
