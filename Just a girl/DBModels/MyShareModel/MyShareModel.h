//
//  MyShareModel.h
//  Just a girl
//
//  Created by xiang on 16/5/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

//我的分享

#import "DBModel.h"

@interface MyShareModel : DBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
/**
 *  用分号分隔的图片链接地址
 */
@property (nonatomic, copy) NSString *imgArr;
@property (nonatomic, assign) NSTimeInterval createTime;
@property (nonatomic, assign) NSInteger isPublishTag;//是否发表的标志，1为已经发表，0为未发表
@property (nonatomic, assign) NSInteger shareType; //1为图片类型，2为文本类型，3为链接类型

+ (NSString *)primaryKey;

@end
