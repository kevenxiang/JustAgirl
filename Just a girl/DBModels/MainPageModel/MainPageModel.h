//
//  MainPageModel.h
//  Just a girl
//
//  Created by xiang on 2016/10/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "DBModel.h"
#import "DBModelHeader.h"
#import <UIKit/UIKit.h>

@interface MainPageModel : DBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *linkUrl;//链接类型的URL
@property (nonatomic, strong) UIImage *linkImage;//l链接类型的图片
/**
 *  用分号分隔的图片链接地址
 */
@property (nonatomic, copy) NSString *imgArr;//图片类型
@property (nonatomic, assign) NSTimeInterval createTime;

+ (NSString *)primaryKey;

@end
