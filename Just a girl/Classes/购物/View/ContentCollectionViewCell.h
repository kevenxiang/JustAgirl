//
//  ContentCollectionViewCell.h
//  Just a girl
//
//  Created by xiang on 16/5/6.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIView *overLayView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
