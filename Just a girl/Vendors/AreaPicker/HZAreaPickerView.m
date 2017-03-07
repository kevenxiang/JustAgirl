//
//  HZAreaPickerView.m
//  AreaPickerDemo
//
//  Created by 向琼 on 16/4/6.
//  Copyright © 2016年 easycol. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
}

@property (strong, nonatomic) UIControl *overlayView;//背景

@end

@implementation HZAreaPickerView

@synthesize overlayView;

@synthesize delegate=_delegate;
@synthesize datasource=_datasource;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;


- (HZLocation *)locate {
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (instancetype)initWithFrame:(CGRect)frame style:(HZAreaPickerStyle)pickerStyle withDelegate:(id<HZAreaPickerDelegate>)delegate andDatasource:(id<HZAreaPickerDatasource>)datasource {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topBgView = [[UIView alloc] init];
        topBgView.backgroundColor = [UIColor whiteColor];
        topBgView.frame = CGRectMake(0, 0, frame.size.width, 40);
        [self addSubview:topBgView];

        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelBtn.frame = CGRectMake(5, 0, 50, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [topBgView addSubview:cancelBtn];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        sureBtn.frame = CGRectMake(frame.size.width - 55, 0, 50, 40);
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [topBgView addSubview:sureBtn];

        
        
        self.locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height - 40)];
        self.locatePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.locatePicker.showsSelectionIndicator = YES;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        self.pickerStyle = pickerStyle;
        [self addSubview:self.locatePicker];
        
        self.delegate = delegate;
        self.datasource = datasource;
        
        provinces = [self.datasource areaPickerData:self];
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0) {
                self.locate.district = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
        } else{
            self.locate.city = [cities objectAtIndex:0];
        }
        
        
        overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [overlayView addTarget:self
                        action:@selector(dismiss)
              forControlEvents:UIControlEventTouchUpInside];


    }
    
    return self;
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 34.0f;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
//        switch (component) {
//            case 0:
//                return [[provinces objectAtIndex:row] objectForKey:@"state"];
//                break;
//            case 1:
//                return [[cities objectAtIndex:row] objectForKey:@"city"];
//                break;
//            case 2:
//                if ([areas count] > 0) {
//                    return [areas objectAtIndex:row];
//                    break;
//                }
//            default:
//                return  @"";
//                break;
//        }
//    } else{
//        switch (component) {
//            case 0:
//                return [[provinces objectAtIndex:row] objectForKey:@"state"];
//                break;
//            case 1:
//                return [cities objectAtIndex:row];
//                break;
//            default:
//                return @"";
//                break;
//        }
//    }
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [cities objectAtIndex:0];
                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                break;
            default:
                break;
        }
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width/3 - 10, 40);
    textLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:textLabel];
    view.backgroundColor = [UIColor clearColor];
    
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                textLabel.text = [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                textLabel.text = [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    textLabel.text = [areas objectAtIndex:row];
                    break;
                }
            default:
                textLabel.text = @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                textLabel.text = [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                textLabel.text = [cities objectAtIndex:row];
                break;
            default:
                textLabel.text = @"";
                break;
        }
    }

    
    
    return view;
}

- (void)sureBtnAction {
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}

#pragma mark - animation
- (void)pop {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:overlayView];
    [keywindow addSubview:self];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height + self.frame.size.height / 2);
    
    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height - self.frame.size.height/2);
    }];

}

- (void)dismiss {
    [overlayView removeFromSuperview];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(keywindow.bounds.size.width/2.0f, keywindow.bounds.size.height + self.frame.size.height / 2 + 20);
    }completion:^(BOOL finished) {
        
    }];

}


@end
