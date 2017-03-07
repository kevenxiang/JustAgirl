//
//  ScanWriteContentCtr.h
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "BaseViewController.h"
#import "DiaryModel.h"

@interface ScanWriteContentCtr : BaseViewController

@property (nonatomic, assign) WriteContentType contentType;
@property (nonatomic, strong) DiaryModel *diary;

@end
