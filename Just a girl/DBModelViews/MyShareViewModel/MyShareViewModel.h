//
//  MyShareViewModel.h
//  Just a girl
//
//  Created by xiang on 16/8/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyShareModel.h"
#import "ShareValue.h"

typedef NS_ENUM(NSUInteger, PublishType) {
    PublishType_NO = 0,//未发表
    PublishType_YES,   //已发表
};

@interface MyShareViewModel : NSObject

+ (BOOL)saveShareDataWithTitle:(NSString *)title content:(NSString *)content imageAry:(NSArray *)imgAry createTime:(NSTimeInterval)time publishTag:(NSInteger)tag shareType:(NSInteger)type;

+ (NSArray *)findAllSharedData;

+ (NSArray *)findAllSharedDataWithPublishTag:(PublishType)tag;

+ (BOOL)updateMyShareToPublishWithId:(NSString *)id;

@end
