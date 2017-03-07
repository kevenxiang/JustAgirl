//
//  ImageScrollView.h
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageScrollView;

@protocol ImageScrollViewDelegate <NSObject>

- (void)imageScrollViewClicked:(UIImage *)image;

@end

@interface ImageScrollView : UIView

- (void)setImageDataWithArray:(NSArray *)ary;

@property (nonatomic, assign) id <ImageScrollViewDelegate> delegate;

@end
