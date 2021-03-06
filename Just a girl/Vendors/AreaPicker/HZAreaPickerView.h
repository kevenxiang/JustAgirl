//
//  HZAreaPickerView.h
//  AreaPickerDemo
//
//  Created by 向琼 on 16/4/6.
//  Copyright © 2016年 easycol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;

@class HZAreaPickerView;

@protocol HZAreaPickerDatasource <NSObject>

- (NSArray *)areaPickerData:(HZAreaPickerView *)picker;

@end

@protocol HZAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker;

@end

@interface HZAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *locatePicker;
@property (assign, nonatomic) id <HZAreaPickerDelegate> delegate;
@property (assign, nonatomic) id <HZAreaPickerDatasource> datasource;
@property (strong, nonatomic) HZLocation *locate;
@property (nonatomic) HZAreaPickerStyle pickerStyle;

- (instancetype)initWithFrame:(CGRect)frame style:(HZAreaPickerStyle)pickerStyle withDelegate:(id <HZAreaPickerDelegate>)delegate andDatasource:(id <HZAreaPickerDatasource>)datasource;


- (void)pop;
- (void)dismiss;

@end
