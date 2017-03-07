//
//  ImageTypeCell.m
//  Just a girl
//
//  Created by xiang on 16/6/3.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ImageTypeCell.h"
#import "FCFileManager.h"

#define kImageViewWidth  80

@interface ImageTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UIView *commentBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *imgBgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dianzanNumLabel;


@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@end

@implementation ImageTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.headImgView.layer.cornerRadius = 22;
    self.headImgView.layer.masksToBounds = YES;
    self.commentBgView.layer.cornerRadius = 5;
    self.commentBgView.layer.masksToBounds = YES;
    
    /*
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    [imageArray addObject:@"background-1.jpg"];
    [imageArray addObject:@"background-2.jpg"];
    [imageArray addObject:@"background-3.jpg"];
    [imageArray addObject:@"background-4.jpg"];
    [imageArray addObject:@"background-5.jpg"];
    [imageArray addObject:@"background-6.jpg"];
    [imageArray addObject:@"background-7.jpg"];
    [imageArray addObject:@"background-8.jpg"];
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake((kImageViewWidth + 8) * i, 10, kImageViewWidth, 100);
        
        imgView.image = [UIImage imageNamed:imageArray[i]];
        imgView.tag = 100 + i;
        imgView.userInteractionEnabled = YES;
        [self.imgBgView addSubview:imgView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTaped:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
    }
    
     self.imgBgView.contentSize = CGSizeMake((kImageViewWidth + 8) * imageArray.count, 100);
*/
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageCellData:(MyShareModel *)data {
    
    if (data.isPublishTag == 0) {//未发表
        self.editBtn.alpha = 1;
        self.deleteBtn.alpha = 1;
        

        self.dianzanBtn.alpha = 0;
        self.dianzanLabel.alpha = 0;
        self.commentBtn.alpha = 0;
        self.commentLable.alpha = 0;
        self.commentBgView.alpha = 0;
        self.commentNumLabel.alpha = 0;
        self.dianzanNumLabel.alpha = 0;
        self.timeLabel.alpha = 0;
        
    } else { //已发表
        self.editBtn.alpha = 0;
        self.deleteBtn.alpha = 0;
    }
    
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
    
    if (data.content.length > 0) {
        self.contentLabel.text = data.content;
    }
    
    NSArray *imageArray = [data.imgArr componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake((kImageViewWidth + 8) * i, 10, kImageViewWidth, 100);
        NSData *imageData = [FCFileManager readFileAtPathAsData:imageArray[i]];
        UIImage *image = [UIImage imageWithData:imageData];
        imgView.image = image;
        
        imgView.tag = 100 + i;
        imgView.userInteractionEnabled = YES;
        [self.imgBgView addSubview:imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTaped:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
    }
    
    self.imgBgView.contentSize = CGSizeMake((kImageViewWidth + 8) * imageArray.count, 100);
    
    
}

- (void)imgTaped:(UITapGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapImage:)]) {
        [self.delegate tapImage:imgView.image];
    }
}

@end
