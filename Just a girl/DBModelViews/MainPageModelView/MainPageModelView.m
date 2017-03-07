//
//  MainPageModelView.m
//  Just a girl
//
//  Created by xiang on 2016/10/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MainPageModelView.h"
#import "MyShareViewModel.h"

@implementation MainPageModelView

+ (NSArray *)findDataFromDB {
    NSArray *resultAry = [MyShareViewModel findAllSharedDataWithPublishTag:PublishType_YES];
    return resultAry;
}

@end
