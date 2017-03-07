//
//  FindDetailViewController.m
//  Just a girl
//
//  Created by xiang on 16/6/16.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "FindDetailViewController.h"

@interface FindDetailViewController ()
{

}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FindDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWEAKSELF;
    [self setRightBarButtonWithTitle:@"收藏" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        
    }];
    
    self.contentLabel.text = @"这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容。这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容。这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容。这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内容，这是文本内";
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - event responds



@end
