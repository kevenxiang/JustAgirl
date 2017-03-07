//
//  ShareViewController.m
//  GirlShare
//
//  Created by xiang on 16/8/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)viewDidLoad {
    [[[self navigationController] navigationBar] setTintColor:[UIColor whiteColor]];
    [[[self navigationController] navigationBar] setBackgroundColor:[UIColor colorWithRed:(62)/255.0 green:(175)/255.0 blue:(252)/255.0 alpha:1]];
    
    
    
    //获取inputItems，在这里itemProvider是你要分享的图片
    NSExtensionItem *firstItem = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider;
    if (firstItem) {
        itemProvider = firstItem.attachments.firstObject;
    }
    
   
   
   
    //这里的kUTTypeImage代指@"public.image"，也就是从相册获取的图片类型
    //这里的kUTTypeURL代指网站链接，如在Safari中打开，则应该拷贝保存当前网页的链接
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            if (!error) {
                //对itemProvider夹带着的URL进行解析
                NSURL *url = (NSURL *)item;
                [UIPasteboard generalPasteboard].URL = url;
                NSLog(@"url =======url item:%@", item);
                
                //获取链接的图片
                [itemProvider loadPreviewImageWithOptions:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                    NSLog(@"item--------:%@", item);
                    self.imgView.image = (UIImage *)item;
                }];
            }
        }];
    }
    
    //获取图片
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            if (!error) {
                //对itemProvider夹带着的图片进行解析
                NSURL *url = (NSURL *)item;
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                self.imgView.image = [UIImage imageWithData:imageData];
                
                NSLog(@"image =======image item:%@", item);
            }
        }];
    }
    
    
    //获取视频
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeMovie]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeMovie options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            if (!error) {
                //对itemProvider夹带着的图片进行解析
                NSURL *url = (NSURL *)item;
                NSData *imageData = [NSData dataWithContentsOfURL:url];
               // self.imgView.image = [self frameImageFromVedioURL:url];
                
                NSLog(@"vedio =======vedio item:%@", item);
                
                //异步获取帧图
                [self centerFrameImageWithVedioURL:url completion:^(UIImage *image) {
                    self.imgView.image = image;
                }];
                
                
            }
        }];
    }
    
    
    //获取邮箱文本信息
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeText]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            if (!error) {
                
                NSLog(@"==========邮件:%@", (NSString *)item);
            }
        }];
    }
    
    
}

//同步获取帧图
- (UIImage *)frameImageFromVedioURL:(NSURL *)vedioURL {
    UIImage *image = nil;
    
    AVAsset *asset = [AVAsset assetWithURL:vedioURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    //get the image from
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}

//异步获取帧图
- (void)centerFrameImageWithVedioURL:(NSURL *)vedioURL completion:(void(^)(UIImage *image))completion {
    AVAsset *asset = [AVAsset assetWithURL:vedioURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    Float64 duration = CMTimeGetSeconds([asset duration]);
    CMTime midpotin = CMTimeMakeWithSeconds(duration / 2.0, 600);
    //异步获取帧图片
    NSValue *midTime = [NSValue valueWithCMTime:midpotin];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[midTime] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (result == AVAssetImageGeneratorSucceeded && image != NULL) {
            UIImage *centerFrameImage = [[UIImage alloc] initWithCGImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(centerFrameImage);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
        }
    }];
}

- (void)didSelectPost {
    
    //加载动画初始化
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake((self.view.frame.size.width - activityIndicatorView.frame.size.width) / 2,
                                             (self.view.frame.size.height - activityIndicatorView.frame.size.height) / 2,
                                             activityIndicatorView.frame.size.width,
                                             activityIndicatorView.frame.size.height);
    activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:activityIndicatorView];
    
    //激活加载动画
    [activityIndicatorView startAnimating];
    
    __weak ShareViewController *theController = self;
    __block BOOL hasExistsUrl = NO;
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        /*
        NSLog(@"self.extensionContext.inputItems==:%@", extItem.attributedContentText.string);
         */
        
        [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            NSLog(@"itemProvider=====:%@", itemProvider);
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.jpeg"]) {
                /*
                [itemProvider loadItemForTypeIdentifier:(NSString *)kCIAttributeIdentity options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                    if (!error) {
                         //对itemProvider夹带着的URL进行解析
                        NSURL *url = (NSURL *)item;
                       [UIPasteboard generalPasteboard].URL = url;
                       NSData *imageData = [NSData dataWithContentsOfURL:url];
                       UIImage *image = [UIImage imageWithData:imageData];
                        NSLog(@"=image==:%@", item);
                    }
                }];
                 */
                
                
            }
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.url"
                                                options:nil
                                      completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                                          
                                          if ([(NSObject *)item isKindOfClass:[NSURL class]])
                                          {
                                              NSLog(@"分享的URL = %@", item);
                                              NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.girlShare"];
                                              [userDefaults setValue:((NSURL *)item).absoluteString forKey:@"share-url"];
                                              //用于标记是新的分享
                                              [userDefaults setBool:YES forKey:@"has-new-share"];
                                              
                                              [activityIndicatorView stopAnimating];
                                              [theController.extensionContext completeRequestReturningItems:@[extItem] completionHandler:nil];
                                          }
                                          
                                          if ([(NSObject *)item isKindOfClass:[UIImage class]]) {
                                              
                                          }
                                          
                                          if ([(NSObject *)item isKindOfClass:[NSString class]] ) {
                                              /*NSLog(@"=============:%@", item);*/
                                          }
                                          
                                      }];
                
                hasExistsUrl = YES;
                *stop = YES;
            }
            
        }];
        
        if (hasExistsUrl)
        {
            *stop = YES;
        }
        
    }];
    
    if (!hasExistsUrl)
    {
        //直接退出
        [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    }
    
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
