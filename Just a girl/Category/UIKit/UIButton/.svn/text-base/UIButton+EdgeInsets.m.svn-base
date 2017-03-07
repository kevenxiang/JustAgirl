//
//  UIButton+EdgeInsets.m
//  APP_iOS
//
//  Created by 林小果 on 15/8/22.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "UIButton+EdgeInsets.h"

@implementation UIButton (EdgeInsets)

- (void)leftTextRightImage {

    UIImage *image = [self.imageView image];
    CGSize imageSize = image.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width-5, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width+5, 0, -self.titleLabel.bounds.size.width)];
}

- (void)topTextBottomImage {
    [self topTextBottomImage:5];
}

- (void)topTextBottomImage:(CGFloat)space {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}
@end
