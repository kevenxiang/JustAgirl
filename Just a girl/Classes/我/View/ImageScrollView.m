//
//  ImageScrollView.m
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ImageScrollView.h"
#import "FCFileManager.h"

#define kImageViewWidth  100

@interface ImageScrollView ()
{
    NSArray *imageArray;
}
@property (nonatomic, strong) UIScrollView *tBgScrollView;

@end

@implementation ImageScrollView
@synthesize tBgScrollView;

- (instancetype)init {
    self = [super init];
    if (self) {
        tBgScrollView = [[UIScrollView alloc] init];
        tBgScrollView.showsVerticalScrollIndicator = NO;
        tBgScrollView.showsHorizontalScrollIndicator = NO;
        tBgScrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        tBgScrollView.backgroundColor = [UIColor redColor];
        [self addSubview:tBgScrollView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        tBgScrollView = [[UIScrollView alloc] init];
        tBgScrollView.showsVerticalScrollIndicator = NO;
        tBgScrollView.showsHorizontalScrollIndicator = NO;
        tBgScrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        tBgScrollView.backgroundColor = [UIColor redColor];
        [self addSubview:tBgScrollView];
    }
    
    return self;
}

- (void)setImageDataWithArray:(NSArray *)ary {
    tBgScrollView = [[UIScrollView alloc] init];
    tBgScrollView.showsVerticalScrollIndicator = NO;
    tBgScrollView.showsHorizontalScrollIndicator = NO;
    tBgScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 16, 120);
    [self addSubview:tBgScrollView];
    imageArray = ary;
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake((kImageViewWidth + 8) * i, 10, kImageViewWidth, 120);
        NSData *imageData = [FCFileManager readFileAtPathAsData:imageArray[i]];
        UIImage *image = [UIImage imageWithData:imageData];
        imgView.image = image;
        imgView.tag = 100 + i;
        imgView.userInteractionEnabled = YES;
        [tBgScrollView addSubview:imgView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTaped:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
    }

    tBgScrollView.contentSize = CGSizeMake((kImageViewWidth + 8) * imageArray.count, 120);
}

- (void)imgTaped:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag;
    NSLog(@"tag=========:%ld", tag);
    UIImageView *imgView = (UIImageView *)sender.view;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageScrollViewClicked:)]) {
        [self.delegate imageScrollViewClicked:imgView.image];
    }
}

@end
