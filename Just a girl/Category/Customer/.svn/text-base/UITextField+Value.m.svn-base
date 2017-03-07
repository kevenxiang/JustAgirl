//
//  UITextField+Value.m
//  KouDaiDuoBao
//
//  Created by 向琼 on 16/4/7.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#import "UITextField+Value.h"

@implementation UITextField (Value)

- (BOOL)haveValue {
    NSString *text = self.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length > 0) {
        return YES;
    }
    
    return NO;
}

- (NSString *)realValue {
    NSString *text = self.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return text;
}

@end
