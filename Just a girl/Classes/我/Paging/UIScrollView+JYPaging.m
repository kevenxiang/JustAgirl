//
//  UIScrollView+JYPaging.m
//  PagingDemo
//
//  Created by Liu jinyong on 15/8/6.
//  Copyright (c) 2015年 Baidu 91. All rights reserved.
//

#import "MJRefresh.h"
#import "UIScrollView+JYPaging.h"

static const float kAnimationDuration = 0.25f;

static const char jy_originContentHeight;
static const char jy_secondScrollView;
static const char scrollTypeKey;

@interface UIScrollView()

@property (nonatomic, assign) float originContentHeight;

@end


@implementation UIScrollView (JYPaging)

@dynamic scrollType;

- (void)setScrollType:(kShowDetailScrollType)scrollType {
    objc_setAssociatedObject(self, &scrollTypeKey, @(scrollType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (kShowDetailScrollType)scrollType {
    return [objc_getAssociatedObject(self, &scrollTypeKey) integerValue];
}

- (void)setOriginContentHeight:(float)originContentHeight {
    objc_setAssociatedObject(self, &jy_originContentHeight, @(originContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)originContentHeight {
    return [objc_getAssociatedObject(self, &jy_originContentHeight) floatValue];
}


- (void)setFirstScrollView:(UIScrollView *)firstScrollView {
    [self addFirstScrollViewFooter];
}

- (UIScrollView *)secondScrollView {
    return objc_getAssociatedObject(self, &jy_secondScrollView);
}

- (void)setSecondScrollView:(UIScrollView *)secondScrollView {
    objc_setAssociatedObject(self, &jy_secondScrollView, secondScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addFirstScrollViewFooter];
    
    CGRect frame = self.bounds;
    frame.origin.y = self.contentSize.height + self.footer.frame.size.height;
    secondScrollView.frame = frame;
    
    [self addSubview:secondScrollView];
    
    [self addSecondScrollViewHeader];
}

- (void)addFirstScrollViewFooter {
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf endFooterRefreshing];
        //发送上拉的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kJYPadingUpLoadNotification" object:nil userInfo:nil];
    }];
    footer.appearencePercentTriggerAutoRefresh = 2;
    if (self.scrollType == kShowDetailScrollType_MyShareDetail) {
         [footer setTitle:@"----- 上拉,查看图片 ------" forState:MJRefreshStateIdle];
    } else if (self.scrollType == kShowDetailScrollType_ProductDetail) {
        [footer setTitle:@"----- 继续拖动,查看图文详情 ------" forState:MJRefreshStateIdle];
    }
   
    
    self.footer = footer;
}

- (void)addSecondScrollViewHeader {
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endHeaderRefreshing];
        //发送下拉的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kJYPadingDownLoadNotification" object:nil userInfo:nil];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    if (self.scrollType == kShowDetailScrollType_MyShareDetail) {
        [header setTitle:@"下拉,返回文字详情" forState:MJRefreshStateIdle];
        [header setTitle:@"释放,返回文字详情" forState:MJRefreshStatePulling];
    } else if (self.scrollType == kShowDetailScrollType_ProductDetail) {
        [header setTitle:@"下拉,返回宝贝详情" forState:MJRefreshStateIdle];
        [header setTitle:@"释放,返回宝贝详情" forState:MJRefreshStatePulling];
    }
   
    
    self.secondScrollView.header = header;
}

- (void)endFooterRefreshing {
    [self.footer endRefreshing];
    self.footer.hidden = YES;
    self.scrollEnabled = NO;
    
    self.secondScrollView.header.hidden = NO;
    self.secondScrollView.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(-self.contentSize.height - self.footer.frame.size.height, 0, 0, 0);
    }];
    
    self.originContentHeight = self.contentSize.height;
    self.contentSize = self.secondScrollView.contentSize;
}

- (void)endHeaderRefreshing {
    [self.secondScrollView.header endRefreshing];
    self.secondScrollView.header.hidden = YES;
    self.secondScrollView.scrollEnabled = NO;
    
    self.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, self.footer.frame.size.height, 0);
    }];
    self.contentSize = CGSizeMake(0, self.originContentHeight);
    
    [self setContentOffset:CGPointZero animated:YES];
    
    [self addFirstScrollViewFooter];
}

@end
