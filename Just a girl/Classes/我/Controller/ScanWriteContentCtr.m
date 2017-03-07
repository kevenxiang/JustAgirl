//
//  ScanWriteContentCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/2.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ScanWriteContentCtr.h"
#import "ImageScrollView.h"
#import "ScanImageViewController.h"

@interface ScanWriteContentCtr () <ImageScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet ImageScrollView *imgScanScrollView;

@end

@implementation ScanWriteContentCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.contentType == WriteContentType_Diary) {
        
        self.navigationItem.title = @"日记";
        
        _titleLabel.text = self.diary.title;
        _contentTextView.text = self.diary.content;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:self.diary.detailTime];
        NSString *timeStr = [formatter stringFromDate:date];
        _timeLabel.text = timeStr;
        
        if (self.diary.imgArr.length > 0) {
            NSArray *imgAry = [self.diary.imgArr componentsSeparatedByString:@","];
            [_imgScanScrollView setImageDataWithArray:imgAry];
            _imgScanScrollView.delegate = self;
        }
       
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - ImageScrollViewDelegate
- (void)imageScrollViewClicked:(UIImage *)image {
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.scanImage = image;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
}

@end
