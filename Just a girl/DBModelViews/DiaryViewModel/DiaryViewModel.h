//
//  DiaryViewModel.h
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

//我的日记

#import <Foundation/Foundation.h>
#import "DiaryModel.h"
#import "DefineConfig.h"
#import "ShareValue.h"

@interface DiaryViewModel : NSObject

/**
 creatTime 时间格式 @"2016-05-24"
 */
+ (BOOL)saveDiaryWithTitle:(NSString *)title content:(NSString *)content imgAray:(NSArray *)imgAry creatTime:(NSString *)creatTime;

+ (BOOL)updateDiaryWithID:(NSString *)id title:(NSString *)title content:(NSString *)content imgAry:(NSArray *)imgAry;

+ (BOOL)deleteDiaryWithId:(NSString *)id;

//根据创建时间查询当天所有的日记
+ (NSArray *)findDiaryWithCreateTime:(NSString *)createTime;

//查找所有数据
+ (NSArray *)findAllData;

@end
