//
//  ImageAndDeleteBtn.m
//  Just a girl
//
//  Created by xiang on 16/5/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ImageAndDeleteBtn.h"

#define kDeleteBtnWidth   23
#define kDeleteBtnHeight  23

@interface ImageAndDeleteBtn ()

@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation ImageAndDeleteBtn

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setImage:[UIImage imageNamed:@"图片删除"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteBtn];
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
     self.deleteBtn.frame = CGRectMake(self.bounds.size.width - kDeleteBtnWidth, 0, kDeleteBtnWidth, kDeleteBtnHeight);
}

- (void)deleteBtnAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClicked:)]) {
        [self.delegate deleteBtnClicked:self];
    }
}

@end
