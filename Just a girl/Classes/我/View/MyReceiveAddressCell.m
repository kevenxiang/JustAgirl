//
//  ReceiveAddressCell.m
//  Just a girl
//
//  Created by xiang on 16/6/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MyReceiveAddressCell.h"

@interface MyReceiveAddressCell ()
{
    ReceiveAddressModel *model;
}

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;
@property (weak, nonatomic) IBOutlet UIButton *isDefaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@end

@implementation MyReceiveAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(ReceiveAddressModel *)data {
    
    model = data;
    
    self.userName.text = data.userName;
    self.userPhone.text = data.userPhone;
    self.userAddress.text = [NSString stringWithFormat:@"%@   %@", data.userArea, data.userAddress];
    if (data.isDefaultAddress == 1) {
        [self.isDefaultBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    } else {
        [self.isDefaultBtn setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
    }
}

- (IBAction)isDefaultBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(isDefaultBtnAction:)]) {
        [self.delegate isDefaultBtnAction:self.indexRow];
    }
}

- (IBAction)editBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editBtnAction:)]) {
        [self.delegate editBtnAction:self.indexRow];
    }
}

- (IBAction)deleteBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnAction:)]) {
        [self.delegate deleteBtnAction:self.indexRow];
    }
}

@end
