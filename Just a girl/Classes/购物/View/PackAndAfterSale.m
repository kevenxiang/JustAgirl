//
//  PackAndAfterSale.m
//  Just a girl
//
//  Created by xiang on 2016/11/15.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "PackAndAfterSale.h"

@interface PackAndAfterSale ()

@property (nonatomic, strong) UITextView *contentLabel;

@end

@implementation PackAndAfterSale

#pragma mark - life cycle 
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initContentLabel];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentLabel];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.contentLabel.frame = CGRectMake(10, 36, self.bounds.size.width - 20, self.bounds.size.height - 60);
}

#pragma mark - getting and setting
- (void)initContentLabel {
    if (!self.contentLabel) {
        self.contentLabel = [[UITextView alloc] init];
        self.contentLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.contentLabel.editable = NO;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.contentLabel];
        
        self.contentLabel.text = @"这里是一些包装和售后的信息,这里是一些包装和售后的信息,这里是一些包装和售后的信息,这里是一些包装和售后的信息,这里是一些包装和售后的信息。";
    }
}

@end
