//
//  BaseViewController.h
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Block.h"
#import "DefineConfig.h"
#import "UIScreen+Additions.h"
#import "FCFileManager.h"
#import "UITextField+Value.h"
#import "BaseButton.h"
#import "DBModelViewsHeader.h"
#import "ShareValue.h"
#import "NSString+Hash.h"
#import "ReactiveCocoa.h"
#import "EXTScope.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"

#define kNavBarHeight       44
#define kLeftMargin        (-5)
#define kRightMargin       (-10)
#define kIOS7OrLater       (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
#define kDefaultFontSize  15

typedef void (^TouchedBlock)(NSInteger tag);

@interface BaseViewController : UIViewController

//可以用来方便的计算cell的高度
@property (nonatomic, strong) UILabel *label;

- (void)setLeftBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block;
- (void)setLeftBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(TouchedBlock)block;
- (void)setLeftBarButtonWithImage:(UIImage *)image withHighLightedImage:(UIImage *)highlightedImage;
- (void)setLeftBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block;

- (void)setRightBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block;
- (void)setRightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(TouchedBlock)block;
- (void)setRightBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block;

- (void)backAction;
- (void)showTabBar;
- (void)hideTabBar;
- (void)rightSwipeGestureAction;
- (void)navigationBarAction;

@end
