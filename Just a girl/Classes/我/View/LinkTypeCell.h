//
//  LinkTypeCell.h
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LinkTypeCellDelegate <NSObject>

- (void)linkClickedWithIndexRow:(NSInteger)indexRow;

@end

@interface LinkTypeCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexRow;

@property (nonatomic, assign) id <LinkTypeCellDelegate> delegate;

@end
