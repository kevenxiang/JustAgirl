//
//  ImageTypeCell.h
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBModelViewsHeader.h"

@protocol ImageTypeCellDelegate <NSObject>

- (void)tapImage:(UIImage *)img;

@end

@interface ImageTypeCell : UITableViewCell

@property (nonatomic, assign) id <ImageTypeCellDelegate> delegate;

- (void)setImageCellData:(MyShareModel *)data;

@end
