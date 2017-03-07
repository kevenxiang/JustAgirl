//
//  ImageTitleCell.m
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ImageTitleCell.h"

@interface ImageTitleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;


@end

@implementation ImageTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.commentNumLabel.layer.cornerRadius = 2;
    self.commentNumLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
