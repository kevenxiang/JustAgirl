//
//  UIScrollView+JYPaging.h
//  PagingDemo
//
//  Created by Liu jinyong on 15/8/6.
//  Copyright (c) 2015年 Baidu 91. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kShowDetailScrollType) {
    kShowDetailScrollType_MyShareDetail = 0,
    kShowDetailScrollType_ProductDetail
};

@interface UIScrollView (JYPaging)

@property (nonatomic, strong) UIScrollView *secondScrollView;
@property (nonatomic, assign) kShowDetailScrollType scrollType;

@end
