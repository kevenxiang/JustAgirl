//
//  SlideButtonView.h
//  FreshSend
//
//  Created by 向琼 on 15/9/4.
//  Copyright (c) 2015年 easyco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideButtonViewDelegate <NSObject>

-(void)slideButtonAction:(UIButton *)sender;

@end

@interface SlideButtonView : UIView


@property (nonatomic, assign) id<SlideButtonViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnAry;
- (void)buttonActionWithTag:(NSInteger)tag;

@end
