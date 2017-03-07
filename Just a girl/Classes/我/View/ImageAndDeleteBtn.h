//
//  ImageAndDeleteBtn.h
//  Just a girl
//
//  Created by xiang on 16/5/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageAndDeleteBtn;

@protocol ImageAndDeleteBtnDelegate <NSObject>

- (void)deleteBtnClicked:(ImageAndDeleteBtn *)img;

@end

@interface ImageAndDeleteBtn : UIImageView

@property (nonatomic, assign) id <ImageAndDeleteBtnDelegate> delegate;

@end
