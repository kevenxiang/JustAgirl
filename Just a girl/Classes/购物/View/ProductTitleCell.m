//
//  ProductTitleCell.m
//  Just a girl
//
//  Created by xiang on 16/6/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ProductTitleCell.h"

@interface ProductTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation ProductTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    NSString *priceStr = @"￥158.00";
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributeStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} range:NSMakeRange(0, 1)];
    [attributeStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} range:NSMakeRange(priceStr.length - 2, 2)];
    self.priceLabel.attributedText = attributeStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
