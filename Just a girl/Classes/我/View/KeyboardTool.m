//
//  KeyboardTool.m
//  Just a girl
//
//  Created by xiang on 16/5/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "KeyboardTool.h"

@interface KeyboardTool ()

//相册
@property (nonatomic, strong) UIButton *albumBtn;
//相机
@property (nonatomic, strong) UIButton *cameraBtn;
//弹下
@property (nonatomic, strong) UIButton *dismissKeyBtn;

@end

@implementation KeyboardTool

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.barStyle = UIBarStyleDefault;
        
        //相册
        _albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.albumBtn setTitle:@"相册" forState:UIControlStateNormal];
        [self.albumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.albumBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.albumBtn addTarget:self action:@selector(albumBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.albumBtn];
        
        //相机
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cameraBtn setTitle:@"相机" forState:UIControlStateNormal];
        [self.cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cameraBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.cameraBtn addTarget:self action:@selector(cameraBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cameraBtn];
        
        _dismissKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.dismissKeyBtn setTitle:@"弹下" forState:UIControlStateNormal];
        [self.dismissKeyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.dismissKeyBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.dismissKeyBtn addTarget:self action:@selector(dismissKeyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.dismissKeyBtn];
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.albumBtn.frame = CGRectMake(self.bounds.size.width - 100, 0, 45, self.bounds.size.height);
    self.cameraBtn.frame = CGRectMake(self.bounds.size.width - 50, 0, 45, self.bounds.size.height);
    self.dismissKeyBtn.frame = CGRectMake(10, 0, 45, self.bounds.size.height);
}

- (void)albumBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(albumBtnAction)]) {
        [self.delegate albumBtnAction];
    }
}

- (void)cameraBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cameraBtnAction)]) {
        [self.delegate cameraBtnAction];
    }
}

- (void)dismissKeyBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissKeyBtnAction)]) {
        [self.delegate dismissKeyBtnAction];
    }
}


@end
