//
//  TitleRightImageCell.m
//  KouDaiDuoBao
//
//  Created by 向琼 on 16/4/5.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#import "TitleRightImageCell.h"

@implementation TitleRightImageCell

- (void)awakeFromNib {
    _imgView.layer.cornerRadius = 25;
    _imgView.layer.masksToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
