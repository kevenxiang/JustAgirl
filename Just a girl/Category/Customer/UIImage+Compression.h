//
//  UIImage+Compression.h
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)

//等比例压缩图片
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
