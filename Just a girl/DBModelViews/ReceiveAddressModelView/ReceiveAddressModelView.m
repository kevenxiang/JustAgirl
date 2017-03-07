//
//  ReceiveAddressModelView.m
//  Just a girl
//
//  Created by xiang on 16/8/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ReceiveAddressModelView.h"

@implementation ReceiveAddressModelView

+ (void)addUserAddressWithName:(NSString *)name phone:(NSString *)phone userArea:(NSString *)area userAddress:(NSString *)address isDefault:(NSInteger)defAddr {
    UserModel *user = [ShareValue instance].user;
    ReceiveAddressModel *model = [[ReceiveAddressModel alloc] init];
    model.id = [ReceiveAddressModel genUUID];
    model.userId = user.uid;
    model.userName = name;
    model.userPhone = phone;
    model.userArea = area;
    model.userAddress = address;
    model.isDefaultAddress = defAddr;
    [model save];
}

+ (NSArray *)findAllAddress {
    UserModel *user = [ShareValue instance].user;
    NSString *condition = [NSString stringWithFormat:@"where userId = '%@'" , user.uid];
    NSArray *resultAry = [ReceiveAddressModel queryByCondition:condition];
    return resultAry;
}

+ (void)updateUserAddressWithName:(NSString *)name phone:(NSString *)phone userArea:(NSString *)area userAddress:(NSString *)address isDefault:(NSInteger)defAddr addrId:(NSString *)id {
    NSString *condition = [NSString stringWithFormat:@"where id = '%@'" , id];
    ReceiveAddressModel *model = [ReceiveAddressModel queryFirstByCondition:condition];
    if (model != nil) {
        model.userName = name;
        model.userPhone = phone;
        model.userArea = area;
        model.userAddress = address;
        model.isDefaultAddress = defAddr;
        [model update];
    }
}

@end
