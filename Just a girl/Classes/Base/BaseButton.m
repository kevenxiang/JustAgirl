//
//  BaseButton.m
//  Just a girl
//
//  Created by xiang on 16/7/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = self.cornerRadius > 0 ? true:false;
}

@end
