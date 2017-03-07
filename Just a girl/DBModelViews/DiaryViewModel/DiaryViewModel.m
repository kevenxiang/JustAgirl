//
//  DiaryViewModel.m
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "DiaryViewModel.h"

@implementation DiaryViewModel

+ (BOOL)saveDiaryWithTitle:(NSString *)title content:(NSString *)content imgAray:(NSArray *)imgAry creatTime:(NSString *)creatTime {
    UserModel *user = [ShareValue instance].user;
    NSString *userId;
    if (user.uid.length > 0) {
        userId = user.uid;
    } else {
        userId = kDefaultUserId;
    }
    
    DiaryModel *diary = [[DiaryModel alloc] init];
    diary.id = [DiaryModel genUUID];
    diary.uid = userId;
    diary.title = title;
    diary.content = content;
    diary.imgArr = [imgAry componentsJoinedByString:@","];
    diary.createTime = creatTime;
    diary.detailTime = [[NSDate date] timeIntervalSince1970];
    if ([diary save]) {
        return YES;
    } else {
        return  NO;
    }
}

+ (BOOL)updateDiaryWithID:(NSString *)id title:(NSString *)title content:(NSString *)content imgAry:(NSArray *)imgAry {
    NSArray *diaryAry = [DiaryModel queryByCondition:[NSString stringWithFormat:@"where id = '%@'", id]];
    if(diaryAry.count > 0) {
        UserModel *user = [ShareValue instance].user;
        NSString *userId;
        if (user.uid.length > 0) {
            userId = user.uid;
        } else {
            userId = kDefaultUserId;
        }
        DiaryModel *diary = diaryAry[0];
        diary.title = title;
        diary.content = content;
        diary.imgArr = [imgAry componentsJoinedByString:@","];
        diary.uid = userId;
        if([diary update]) {
            return YES;
        } else {
            return  NO;
        }
    } else {
        return NO;
    }
}

+ (BOOL)deleteDiaryWithId:(NSString *)id {
    if([DiaryModel deleteObjectsByCriteria:[NSString stringWithFormat:@"where id = '%@'", id]]) {
        return YES;
    } else {
        return NO;
    }
    
}

//根据创建时间查询当天所有的日记
+ (NSArray *)findDiaryWithCreateTime:(NSString *)createTime {
    NSArray *diaryAry = [DiaryModel queryByCondition:[NSString stringWithFormat:@"where createTime = '%@'", createTime]];
     return diaryAry;
}

//查找所有数据
+ (NSArray *)findAllData {
    UserModel *user = [ShareValue instance].user;
    NSString *condition = [NSString stringWithFormat:@"where uid = '%@'", user.uid];
    NSArray *arr = [DiaryModel queryByCondition:condition];
    return arr;
}

@end
