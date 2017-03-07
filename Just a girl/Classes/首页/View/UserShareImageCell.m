//
//  UserShareImageCell.m
//  Just a girl
//
//  Created by xiang on 16/5/10.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "UserShareImageCell.h"

@interface UserShareImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIView *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation UserShareImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgView.layer.cornerRadius = 25.0f;
    self.headImgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCellWithData:(NSString *)str {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:str] + 45.0f);
}

+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}

@end
