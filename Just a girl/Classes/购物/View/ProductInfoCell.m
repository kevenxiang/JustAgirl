//
//  ProductInfoCell.m
//  Just a girl
//
//  Created by xiang on 16/6/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ProductInfoCell.h"

@interface ProductInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

@implementation ProductInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view2.backgroundColor = [UIColor lightGrayColor];
    self.view3.backgroundColor = [UIColor darkGrayColor];
    
    self.view1.layer.cornerRadius = 2.5;
    self.view1.layer.masksToBounds = YES;
    self.view2.layer.cornerRadius = 2.5;
    self.view2.layer.masksToBounds = YES;
    self.view3.layer.cornerRadius = 2.5;
    self.view3.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
