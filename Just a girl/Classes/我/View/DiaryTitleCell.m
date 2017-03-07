//
//  DiaryTitleCell.m
//  Just a girl
//
//  Created by xiang on 16/5/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "DiaryTitleCell.h"

@interface DiaryTitleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation DiaryTitleCell

- (void)setData:(DiaryModel *)model {
    NSString *title;
    if (model.title.length > 0) {
        title = model.title;
    } else {
        if (model.content.length > 40) {
            title = [model.content substringWithRange:NSMakeRange(0, 40)];
            title = [NSString stringWithFormat:@"%@...", title];
        } else {
            title = model.content;
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:model.detailTime];
    NSString *timeStr = [formatter stringFromDate:date];
    timeStr = [timeStr substringWithRange:NSMakeRange(timeStr.length - 5, 5)];
    
    _titleLable.text = title;
    _timeLabel.text = timeStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
