//
//  BaseButton.h
//  Just a girl
//
//  Created by xiang on 16/7/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

#ifndef IBInspectable
#define IBInspectable
#endif

@interface BaseButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
