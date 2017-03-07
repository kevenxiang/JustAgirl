//
//  KeyboardTool.h
//  Just a girl
//
//  Created by xiang on 16/5/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardToolDelegate <NSObject>

- (void)albumBtnAction;
- (void)cameraBtnAction;
- (void)dismissKeyBtnAction;

@end

@interface KeyboardTool : UIToolbar

@property (nonatomic, assign) id <KeyboardToolDelegate> delegate;

@end
