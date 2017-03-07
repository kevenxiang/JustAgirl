//
//  XPopView.h
//  Transform
//
//  Created by xiang on 16/6/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XPopViewDelegate <NSObject>

- (void)dismissDelegate;

@end

@interface XPopView : UIView

@property (nonatomic, assign) id <XPopViewDelegate> delegate;

/**
 *  弹出
 */
- (void)pop;

/**
 *  消失
 */
- (void)dismiss;

@end
