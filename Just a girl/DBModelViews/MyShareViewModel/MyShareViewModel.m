//
//  MyShareViewModel.m
//  Just a girl
//
//  Created by xiang on 16/8/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyShareViewModel.h"

@implementation MyShareViewModel

+ (BOOL)saveShareDataWithTitle:(NSString *)title content:(NSString *)content imageAry:(NSArray *)imgAry createTime:(NSTimeInterval)time publishTag:(NSInteger)tag shareType:(NSInteger)type {
    NSString *userId = [ShareValue instance].user.uid;
    MyShareModel *shareModel = [[MyShareModel alloc] init];
    shareModel.id = [MyShareModel genUUID];
    shareModel.uid = userId;
    shareModel.title = title;
    shareModel.content = content;
    shareModel.imgArr = [imgAry componentsJoinedByString:@","];
    shareModel.createTime = time;
    shareModel.isPublishTag = tag;
    shareModel.shareType = type;
    if ([shareModel save]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSArray *)findAllSharedData {
    NSString *userId = [ShareValue instance].user.uid;
    NSString *condition = [NSString stringWithFormat:@"where uid = '%@'", userId];
    NSArray *arr = [MyShareModel queryByCondition:condition];
    return arr;
}

+ (NSArray *)findAllSharedDataWithPublishTag:(PublishType)tag {
    NSString *userId = [ShareValue instance].user.uid;
    NSString *condition = [NSString stringWithFormat:@"where uid = '%@' and isPublishTag = %ld order by createTime desc", userId, tag];
    NSArray *arr = [MyShareModel queryByCondition:condition];
    return arr;
}

+ (BOOL)updateMyShareToPublishWithId:(NSString *)id {
    NSString *userId = [ShareValue instance].user.uid;
    NSString *condition = [NSString stringWithFormat:@"where uid='%@' and id='%@'", userId, id];
    NSArray *arr = [MyShareModel queryByCondition:condition];
    MyShareModel *model;
    if (arr.count > 0) {
        model = arr[0];
    }
    
    model.isPublishTag = 1;
    return [model update];
}

@end
