//
//  ReceiveAddressModel.h
//  Just a girl
//
//  Created by xiang on 16/8/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "DBModel.h"

@interface ReceiveAddressModel : DBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *userArea;
@property (nonatomic, copy) NSString *userAddress;
@property (nonatomic, assign) NSInteger isDefaultAddress;//是否是默认地址,1为默认地址

+ (NSString *)primaryKey;

@end
