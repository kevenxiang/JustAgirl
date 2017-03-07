//
//  ShoppingCartCell.h
//  Just a girl
//
//  Created by xiang on 16/6/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexRow;

- (void)selectWithTag:(BOOL)tag;
- (void)cellIsSelect:(BOOL)bol;
- (void)setData;

@end
