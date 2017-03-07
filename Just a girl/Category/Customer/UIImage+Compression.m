//
//  UIImage+Compression.m
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)

//等比例压缩图片
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnaiPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnaiPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnaiPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnaiPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"scale iamge fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
