//
//  UIImageView+GetImageWithURL.m
//  KouDaiDuoBao
//
//  Created by 向琼 on 16/4/15.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#import "UIImageView+GetImageWithURL.h"

@implementation UIImageView (GetImageWithURL)

- (void)getImageWithUrl:(NSURL *)url placeHolder:(UIImage *)pImage {
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        __block UIImage *image = nil;
        dispatch_sync(concurrentQueue, ^{
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            
            NSError *error = nil;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
            if (error == nil && imageData != nil) {
                image = [UIImage imageWithData:imageData];
            }
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (image != nil) {
                self.image = image;
            } else {
                self.image = pImage;
            }
        });
    });
}

@end
