//
//  PersonCenterImageAndTitleCell.m
//  KouDaiDuoBao
//
//  Created by 向琼 on 16/3/31.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#import "PersonCenterImageAndTitleCell.h"

@interface PersonCenterImageAndTitleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PersonCenterImageAndTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithTitle:(NSString *)title imageName:(NSString *)imgName {
    _titleLabel.text = title;
    _titleImgView.image = [UIImage imageNamed:imgName];
}

@end
