//
//  LinkTypeCell.m
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "LinkTypeCell.h"

@interface LinkTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UIView *commentBgView;
@property (weak, nonatomic) IBOutlet UIView *linkBgView;
@property (weak, nonatomic) IBOutlet UIImageView *linkImgView;
@property (weak, nonatomic) IBOutlet UILabel *linkTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LinkTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImgView.layer.cornerRadius = 22;
    self.headImgView.layer.masksToBounds = YES;
    self.linkImgView.layer.cornerRadius = 2;
    self.linkImgView.layer.masksToBounds = YES;
    self.linkBgView.layer.cornerRadius = 5;
    self.linkBgView.layer.masksToBounds = YES;
    self.commentBgView.layer.cornerRadius = 5;
    self.commentBgView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkTapAction:)];
    [self.linkBgView addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)linkTapAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(linkClickedWithIndexRow:)]) {
        [self.delegate linkClickedWithIndexRow:self.indexRow];
    }
}

@end
