//
//  TextTypeCell.m
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "TextTypeCell.h"

@interface TextTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UIView *commentBgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation TextTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImgView.layer.cornerRadius = 22;
    self.headImgView.layer.masksToBounds = YES;
    self.commentBgView.layer.cornerRadius = 5;
    self.commentBgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTextCellData:(MyShareModel *)model {
    UIImage *image;
    if ([ShareValue instance].user.headImg.length > 0) {
        NSData *imageData = [FCFileManager readFileAtPathAsData:[ShareValue instance].user.headImg];
        image = [UIImage imageWithData:imageData];
    }
    if (image) {
        self.headImgView.image = image;
    }
    
    if ([ShareValue instance].user.username.length > 0) {
        self.nameLabel.text = [ShareValue instance].user.username;
    } else {
        self.nameLabel.text = [ShareValue instance].user.mobile;
    }
    
    if (model.content.length > 0) {
        self.contentLabel.text = model.content;
    }


}

@end
