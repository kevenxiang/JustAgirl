//
//  ReceiveAddressCell.h
//  Just a girl
//
//  Created by xiang on 16/6/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiveAddressModel.h"

@protocol MyReceiveAddressCellDelegate <NSObject>

- (void)isDefaultBtnAction:(NSInteger)indexRow;
- (void)editBtnAction:(NSInteger)indexRow;
- (void)deleteBtnAction:(NSInteger)indexRow;

@end

@interface MyReceiveAddressCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, assign) id <MyReceiveAddressCellDelegate> delegate;

- (void)setData:(ReceiveAddressModel *)data;

@end
