//
//  SlideButtonView.m
//  FreshSend
//
//  Created by 向琼 on 15/9/4.
//  Copyright (c) 2015年 easyco. All rights reserved.
//

#import "SlideButtonView.h"
#import <objc/runtime.h>

#define ButtonHeight  38
#define LineHeight    2
#define SelectedBtnTitleColor  [UIColor redColor]
#define Ratio   0.75

static NSString *SLIDE_ITEM_ASS_KEY = @"xlovex";

@interface SlideButtonView ()
{
    NSMutableArray *btnArray;
    UIView *bottomLineView;
}

@end

@implementation SlideButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnAry {
    self = [super initWithFrame:frame];
    if (self) {
        btnArray = [[NSMutableArray alloc]init];
        NSString *btnTitle;
        
        for (NSInteger i = 0; i < btnAry.count; i++) {
            
            btnTitle = btnAry[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100+i;
            button.frame = CGRectMake((self.bounds.size.width/btnAry.count) * i, 1, (self.bounds.size.width/btnAry.count), self.bounds.size.height - 2);
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:btnTitle forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [btnArray addObject:button];
            if (button.tag == 100) {
                [button setTitleColor:SelectedBtnTitleColor forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            }
            
            //竖线
//            UIView *bLine = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width / btnAry.count) * i + (self.bounds.size.width / btnAry.count), 5, 1, self.bounds.size.height - 10)];
//            bLine.backgroundColor = [UIColor lightGrayColor];
//            [self addSubview:bLine];
            
        }
        
        bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width/btnAry.count, LineHeight)];
        bottomLineView.backgroundColor = [UIColor redColor];
        [self addSubview:bottomLineView];
        
        objc_setAssociatedObject(self, (__bridge const void *)SLIDE_ITEM_ASS_KEY, btnAry, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
   
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    NSArray *btnAry = objc_getAssociatedObject(self, (__bridge const void *)SLIDE_ITEM_ASS_KEY);
    UIButton *btn = sender;
    NSUInteger i = btn.tag;
    CGRect lineFrame = btn.frame;
    CGFloat lineStartX = lineFrame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineView.frame = CGRectMake(lineStartX, self.bounds.size.height-2, self.bounds.size.width/btnAry.count, LineHeight);
    }completion:^(BOOL finished) {
        
    }];
    for (int j = 0; j < btnArray.count; j++) {
        UIButton *button = btnArray[j];
        if (button.tag == i) {
            [button setTitleColor:SelectedBtnTitleColor forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
        }else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
        }
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideButtonAction:)]) {
        [self.delegate slideButtonAction:sender];
    }
    
}

- (void)buttonActionWithTag:(NSInteger)tag {
    NSArray *btnAry = objc_getAssociatedObject(self, (__bridge const void *)SLIDE_ITEM_ASS_KEY);
    NSUInteger i = tag;
    UIButton *btn = btnArray[i];
    CGRect lineFrame = btn.frame;
    CGFloat lineStartX = lineFrame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineView.frame = CGRectMake(lineStartX, self.bounds.size.height-2, self.bounds.size.width/btnAry.count, LineHeight);
    }completion:^(BOOL finished) {
        
    }];
    for (int j = 0; j < btnArray.count; j++) {
        UIButton *button = btnArray[j];
        if (button == btn) {
            [button setTitleColor:SelectedBtnTitleColor forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
        }else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
        }
        
    }

}


@end
