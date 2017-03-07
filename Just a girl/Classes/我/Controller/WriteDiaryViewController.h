//
//  WriteDiaryViewController.h
//  Just a girl
//
//  Created by xiang on 16/5/23.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "BaseViewController.h"
#import "FSCalendar.h"

@interface WriteDiaryViewController : BaseViewController <FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@end
