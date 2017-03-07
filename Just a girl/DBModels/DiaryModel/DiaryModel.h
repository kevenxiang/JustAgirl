//
//  DiaryModel.h
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

//我的日记model

#import "DBModel.h"

@interface DiaryModel : DBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imgArr;
/**
 时间格式 @"2016-05-24"
 */
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) NSTimeInterval detailTime;

+ (NSString *)primaryKey;

@end
