//
//  XPopView.m
//  Transform
//
//  Created by xiang on 16/6/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "XPopView.h"
#import "DefineConfig.h"

#define kProductImgHeight   100

@interface XPopView ()

@property (strong, nonatomic) UIControl *overlayView;//背景

//编辑商品数量
@property (nonatomic, strong) UIImageView *productImgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *productNumLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *showNumLabel;
@property (nonatomic, strong) UIImageView *addAndReduceImgView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *reduceBtn;
@property (nonatomic, strong) UITextField *numTextField;
@property (nonatomic, strong) UIButton *buyBtn;


@end

@implementation XPopView

@synthesize overlayView;


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
//        [self editBuyNumTypeInit];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.closeBtn];
    }
    
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
     overlayView.frame = [UIScreen mainScreen].bounds;
    
    //编辑商品数量
    self.productImgView.frame = CGRectMake(10, -20, kProductImgHeight, kProductImgHeight);
    self.closeBtn.frame = CGRectMake(self.bounds.size.width - 30, 5, 23, 23);
    self.priceLabel.frame = CGRectMake(120, kProductImgHeight - 60, self.bounds.size.width - kProductImgHeight - 30, 21);
    self.productNumLabel.frame = CGRectMake(120, kProductImgHeight - 35, self.bounds.size.width - kProductImgHeight - 30, 21);
    self.line.frame = CGRectMake(0, 90, self.bounds.size.width, 1.0);
    
    self.showNumLabel.frame = CGRectMake(10, 108, 60, 21);
    self.addAndReduceImgView.frame = CGRectMake(self.bounds.size.width - 130, 100, 121, 36);
    self.reduceBtn.frame = CGRectMake(0, 0, 36, 36);
    self.addBtn.frame = CGRectMake(self.addAndReduceImgView.frame.size.width - 36, 0, 36, 36);
    self.numTextField.frame = CGRectMake(36, 0, 45, 36);
    self.buyBtn.frame = CGRectMake(0, self.bounds.size.height - 44, self.bounds.size.width, 44.0f);
}

- (void)editBuyNumTypeInit {
    
    _productImgView = [[UIImageView alloc] init];
    self.productImgView.image = [UIImage imageNamed:@"testImg"];
    self.productImgView.layer.cornerRadius = 3;
    self.productImgView.layer.masksToBounds = YES;
    [self addSubview:self.productImgView];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    _priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.text = @"￥998.0";
    [self addSubview:self.priceLabel];
    
    _productNumLabel = [[UILabel alloc] init];
    self.productNumLabel.textColor = [UIColor darkGrayColor];
    self.productNumLabel.font = [UIFont systemFontOfSize:13];
    self.productNumLabel.text = @"商品编号:2908998";
    [self addSubview:self.productNumLabel];
    
    _line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.line];
    
    _showNumLabel = [[UILabel alloc] init];
    self.showNumLabel.textColor = [UIColor darkGrayColor];
    self.showNumLabel.font = [UIFont systemFontOfSize:13];
    self.showNumLabel.text = @"数量";
    [self addSubview:self.showNumLabel];
    
    _addAndReduceImgView = [[UIImageView alloc] init];
    self.addAndReduceImgView.image = [UIImage imageNamed:@"加减"];
    self.addAndReduceImgView.userInteractionEnabled = YES;
    [self addSubview:self.addAndReduceImgView];
    
    _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addAndReduceImgView addSubview:self.reduceBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addAndReduceImgView addSubview:self.addBtn];
    
    _numTextField = [[UITextField alloc] init];
    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numTextField.font = [UIFont systemFontOfSize:15];
    self.numTextField.textAlignment = NSTextAlignmentCenter;
    self.numTextField.text = @"1";
    [self.addAndReduceImgView addSubview:self.numTextField];
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buyBtn setBackgroundColor:kThemeColor];
    [self.buyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buyBtn];
    
    overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [overlayView addTarget:self
                    action:@selector(dismiss)
          forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - event responds
- (void)closeBtnAction {
    [self dismiss];
}

- (void)reduceBtnAction {
    NSInteger num = [self.numTextField.text integerValue];
    num -= 1;
    if (num <= 1) {
        num = 1;
    }
    self.numTextField.text = [NSString stringWithFormat:@"%ld", num];
}

- (void)addBtnAction {
    NSInteger num = [self.numTextField.text integerValue];
    num += 1;
    self.numTextField.text = [NSString stringWithFormat:@"%ld", num];
}

- (void)buyBtnAction {

}

#pragma mark - public methods
- (void)pop {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:overlayView];
    [keywindow addSubview:self];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height + self.frame.size.height / 2);
    
    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height - self.frame.size.height/2);
    }];
    
}

- (void)dismiss {
    [self endEditing:YES];
    [overlayView removeFromSuperview];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height + self.frame.size.height / 2 + 20);
    }completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(dismissDelegate)]) {
            [self.delegate dismissDelegate];
        }
    }];
}


@end
