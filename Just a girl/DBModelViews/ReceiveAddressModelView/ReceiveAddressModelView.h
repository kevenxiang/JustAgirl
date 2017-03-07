//
//  ReceiveAddressModelView.h
//  Just a girl
//
//  Created by xiang on 16/8/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiveAddressModel.h"
#import "ShareValue.h"

@interface ReceiveAddressModelView : NSObject

+ (void)addUserAddressWithName:(NSString *)name phone:(NSString *)phone userArea:(NSString *)area userAddress:(NSString *)address isDefault:(NSInteger)defAddr;

+ (NSArray *)findAllAddress;

+ (void)updateUserAddressWithName:(NSString *)name phone:(NSString *)phone userArea:(NSString *)area userAddress:(NSString *)address isDefault:(NSInteger)defAddr addrId:(NSString *)id;

@end
