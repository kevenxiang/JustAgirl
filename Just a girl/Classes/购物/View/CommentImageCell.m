//
//  CommentImageCell.m
//  Just a girl
//
//  Created by xiang on 16/6/12.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "CommentImageCell.h"

#define kImageViewWidth  80

@interface CommentImageCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *imgBgView;

@end

@implementation CommentImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
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
        //        NSData *imageData = [FCFileManager readFileAtPathAsData:imageArray[i]];
        //        UIImage *image = [UIImage imageWithData:imageData];
        //        imgView.image = image;
        
        imgView.image = [UIImage imageNamed:imageArray[i]];
        imgView.tag = 100 + i;
        imgView.userInteractionEnabled = YES;
        [self.imgBgView addSubview:imgView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTaped:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
    }
    
    self.imgBgView.contentSize = CGSizeMake((kImageViewWidth + 8) * imageArray.count, 100);


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
