//
//  AddNewReceivePeopleCtr.h
//  Just a girl
//
//  Created by xiang on 16/6/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddNewReceivePeopleCtrDelegate <NSObject>

- (void)refreshReceiveData;

@end

@interface AddNewReceivePeopleCtr : BaseViewController

@property (nonatomic, assign) NSInteger editTag;
@property (nonatomic, strong) ReceiveAddressModel *model;

@property (nonatomic, assign) id <AddNewReceivePeopleCtrDelegate> delegate;

@end
