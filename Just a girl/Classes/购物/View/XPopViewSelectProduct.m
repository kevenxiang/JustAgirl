//
//  XPopView+SelectProduct.m
//  Just a girl
//
//  Created by xiang on 2016/11/15.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "XPopViewSelectProduct.h"
#import "DefineConfig.h"

#define kProductImgHeight   100

@interface XPopViewSelectProduct ()

//编辑商品数量
@property (nonatomic, strong) UIImageView *productImgView;
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

@implementation XPopViewSelectProduct

- (instancetype)init {
    self = [super init];
    if (self) {
        [self editBuyNumTypeInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)editBuyNumTypeInit {
    
    if (!_productImgView) {
        _productImgView = [[UIImageView alloc] init];
        _productImgView.image = [UIImage imageNamed:@"testImg"];
        _productImgView.layer.cornerRadius = 3;
        _productImgView.layer.masksToBounds = YES;
        [self addSubview:_productImgView];
    }
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.text = @"￥998.0";
        [self addSubview:_priceLabel];
    }
   
    if (!_productNumLabel) {
        _productNumLabel = [[UILabel alloc] init];
        _productNumLabel.textColor = [UIColor darkGrayColor];
        _productNumLabel.font = [UIFont systemFontOfSize:13];
        _productNumLabel.text = @"商品编号:2908998";
        [self addSubview:_productNumLabel];
    }
    
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_line];

    }
    
    if (!self.showNumLabel) {
        self.showNumLabel = [[UILabel alloc] init];
        self.showNumLabel.textColor = [UIColor darkGrayColor];
        self.showNumLabel.font = [UIFont systemFontOfSize:13];
        self.showNumLabel.text = @"数量";
        [self addSubview:self.showNumLabel];
    }
    
    
    if (!self.addAndReduceImgView) {
        self.addAndReduceImgView = [[UIImageView alloc] init];
        self.addAndReduceImgView.image = [UIImage imageNamed:@"加减"];
        self.addAndReduceImgView.userInteractionEnabled = YES;
        [self addSubview:self.addAndReduceImgView];
    }
    
    if (!self.reduceBtn) {
        self.reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.addAndReduceImgView addSubview:self.reduceBtn];
    }
    
    if (!self.addBtn) {
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.addAndReduceImgView addSubview:self.addBtn];
    }
    
    if (!self.numTextField) {
        self.numTextField = [[UITextField alloc] init];
        self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.numTextField.font = [UIFont systemFontOfSize:15];
        self.numTextField.textAlignment = NSTextAlignmentCenter;
        self.numTextField.text = @"1";
        [self.addAndReduceImgView addSubview:self.numTextField];
    }
    
    if (!self.buyBtn) {
        self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyBtn setBackgroundColor:kThemeColor];
        [self.buyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buyBtn];
    }
    
    
    NSArray *selectData = @[@"一人份", @"两人份", @"三人份", @"四人份", @"全家份"];
    
    NSInteger maxRow = 2;
    NSInteger maxCol = 4;
    
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / maxCol;
    CGFloat itemHeight = 40.0f ;
   
    for (NSInteger row = 0; row < maxRow; row++) {
        for (NSInteger col = 0; col < maxCol; col++) {
            NSInteger index = row * maxCol + col;
            if (index < selectData.count) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + index;
                button.layer.cornerRadius = 5;
                button.frame = CGRectMake(col * itemWidth + 10, 170 + row * itemHeight, itemWidth - 20, itemHeight - 10);
                [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [button setTitle:selectData[index] forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor lightGrayColor]];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numSelectAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
                
                if (index == 0) {
                    [button setBackgroundColor:kThemeColor];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    //编辑商品数量
    self.productImgView.frame = CGRectMake(10, -20, kProductImgHeight, kProductImgHeight);
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

#pragma mark - event responds
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

- (void)numSelectAction:(UIButton *)sender {
    
    NSArray *selectData = @[@"一人份", @"两人份", @"三人份", @"四人份", @"全家份"];
    NSInteger maxRow = 2;
    NSInteger maxCol = 4;
    for (NSInteger row = 0; row < maxRow; row++) {
        for (NSInteger col = 0; col < maxCol; col++) {
            NSInteger index = row * maxCol + col;
            if (index < selectData.count) {
                UIButton *button = [self viewWithTag:100 + index];
                [button setBackgroundColor:[UIColor lightGrayColor]];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    
    UIButton *button = [self viewWithTag:sender.tag];
    [button setBackgroundColor:kThemeColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)buyBtnAction {
    
}


@end
