//
//  ShoppingCartCell.m
//  Just a girl
//
//  Created by xiang on 16/6/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ShoppingCartCell.h"

#define kImageViewWidth  100

@interface ShoppingCartCell ()
{
    UIView *rootBgView;
    UIView *bgView;
    UIButton *selectBtn;
    UIImageView *imgView;
    UILabel *titleLabel;
    UILabel *showNumLabel;
    UIImageView *addAndReduceBgImgView;
    UIButton *addBtn;
    UIButton *reduceBtn;
    UITextField *numTextFiled;
    UILabel *priceLabel;
    UILabel *productNumLabel;
    NSInteger selectTag;
}

@end

@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        rootBgView = [[UIView alloc] init];
        rootBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:rootBgView];
        
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [rootBgView addSubview:bgView];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
        [selectBtn addTarget:selectBtn action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [rootBgView addSubview:selectBtn];
        
        imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:imgView];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 2;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bgView addSubview:titleLabel];
        
        showNumLabel = [[UILabel alloc] init];
        showNumLabel.numberOfLines = 1;
        [showNumLabel setFont:[UIFont systemFontOfSize:14]];
        showNumLabel.textColor = [UIColor darkGrayColor];
        showNumLabel.text = @"数量";
        [bgView addSubview:showNumLabel];
        
        addAndReduceBgImgView = [[UIImageView alloc] init];
        addAndReduceBgImgView.image = [UIImage imageNamed:@"加减"];
        addAndReduceBgImgView.userInteractionEnabled = YES;
        [bgView addSubview:addAndReduceBgImgView];
        
        reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reduceBtn addTarget:self action:@selector(reduceBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [addAndReduceBgImgView addSubview:reduceBtn];
        
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [addAndReduceBgImgView addSubview:addBtn];
        
        numTextFiled = [[UITextField alloc] init];
        numTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        numTextFiled.font = [UIFont systemFontOfSize:15];
        numTextFiled.textAlignment = NSTextAlignmentCenter;
        numTextFiled.text = @"1";
        [addAndReduceBgImgView addSubview:numTextFiled];
        
        priceLabel = [[UILabel alloc] init];
        priceLabel.numberOfLines = 1;
        [priceLabel setFont:[UIFont systemFontOfSize:15]];
        priceLabel.textColor = [UIColor redColor];
        [bgView addSubview:priceLabel];
        
        productNumLabel = [[UILabel alloc] init];
        productNumLabel.numberOfLines = 1;
        productNumLabel.textAlignment = NSTextAlignmentRight;
        [productNumLabel setFont:[UIFont systemFontOfSize:15]];
        productNumLabel.textColor = [UIColor darkGrayColor];
        [bgView addSubview:productNumLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat offsetX = 0;
    offsetX = self.bounds.size.width / 2 + 60;
    if (rootBgView.center.x == offsetX) {
        
    } else {
        rootBgView.frame = self.contentView.frame;
        selectBtn.frame = CGRectMake(-30, (self.bounds.size.height - 20)/2, 20, 20);
        bgView.frame = CGRectMake(10, 0, self.contentView.frame.size.width - 10, self.contentView.frame.size.height);
        imgView.frame = CGRectMake(0, (self.bounds.size.height - kImageViewWidth)/2, kImageViewWidth, kImageViewWidth);
        titleLabel.frame = CGRectMake(8 + kImageViewWidth, imgView.frame.origin.y, self.contentView.frame.size.width - 8 - kImageViewWidth - 8, 40);
        
        CGFloat startY = imgView.frame.origin.y + 40 + 10;
        showNumLabel.frame = CGRectMake(8 + kImageViewWidth, startY, 50, 21);
        addAndReduceBgImgView.frame = CGRectMake(bgView.frame.size.width - 130, startY - 6, 121, 36);
        reduceBtn.frame = CGRectMake(0, 0, 36, 36);
        addBtn.frame = CGRectMake(addAndReduceBgImgView.frame.size.width - 36, 0, 36, 36);
        numTextFiled.frame = CGRectMake(36, 0, 45, 36);
        
        startY += 10 + 40;
        priceLabel.frame = CGRectMake(8 + kImageViewWidth, startY, 120, 21);
        productNumLabel.frame = CGRectMake(bgView.frame.size.width - 129, startY, 120, 21);
    }
    
    if (selectTag == 1) {
        
        if ([NSRunLoop currentRunLoop].currentMode == UITrackingRunLoopMode) {
            rootBgView.center = CGPointMake(offsetX, self.bounds.size.height/2);
        } else {
            [UIView animateWithDuration:0.25 delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 rootBgView.center = CGPointMake(offsetX, self.bounds.size.height/2);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }

        
    } else if(selectTag == 2) {
        
        if ([NSRunLoop currentRunLoop].currentMode == UITrackingRunLoopMode) {
            rootBgView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                rootBgView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            }];
        }
    }

   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - event responds
- (void)selectBtnAction {

}

- (void)reduceBtnAction {

}

- (void)addBtnAction {

}

#pragma mark - public methods
- (void)setData {
    titleLabel.text = @"商品标题";
    imgView.image = [UIImage imageNamed:@"testImg"];
    priceLabel.text = @"￥199";
    productNumLabel.text = @"x5";
}

- (void)selectWithTag:(BOOL)tag {
    if (tag) {
        selectTag = 1;
        
    } else {
        selectTag = 2;
    }
}

- (void)cellIsSelect:(BOOL)bol {
    if (bol) {
        [selectBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    } else {
        [selectBtn setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
    }
}


@end
