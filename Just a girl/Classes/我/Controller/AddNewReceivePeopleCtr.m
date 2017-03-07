//
//  AddNewReceivePeopleCtr.m
//  Just a girl
//
//  Created by xiang on 16/6/25.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "AddNewReceivePeopleCtr.h"
#import "HZAreaPickerView.h"
#import "ValidatePhoneNumber.h"

@interface AddNewReceivePeopleCtr () <HZAreaPickerDelegate, HZAreaPickerDatasource>

@property (nonatomic, strong) NSString *areaValue;
@property (nonatomic, strong) HZAreaPickerView *locatePicker;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UIButton *userArea;
@property (weak, nonatomic) IBOutlet UITextField *userDetailAddress;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, strong) RACCommand *addrCommand;

@end

@implementation AddNewReceivePeopleCtr

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
   
    if (self.editTag == 1) {
        self.navigationItem.title = @"编辑收货人";
        self.userName.text = self.model.userName;
        self.userPhone.text = self.model.userPhone;
        [self.userArea setTitle:self.model.userArea forState:UIControlStateNormal];
        self.userDetailAddress.text = self.model.userAddress;
    } else {
        self.navigationItem.title = @"新建收货人";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - HZAreaPicker delegate
- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker {
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        [self.selectAreaBtn setTitle:self.areaValue forState:UIControlStateNormal];
    }
}

- (NSArray *)areaPickerData:(HZAreaPickerView *)picker {
    NSArray *data;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    } else {
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    }
    return data;
}


#pragma mark - event responds
- (IBAction)selectAreaAction:(id)sender {
    [self.view endEditing:YES];
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220) style:HZAreaPickerWithStateAndCityAndDistrict withDelegate:self andDatasource:self];
    self.locatePicker.backgroundColor = [UIColor whiteColor];
    [self.locatePicker pop];
}

- (IBAction)saveAddrBtnAction:(id)sender {
    NSString *userName = [self.userName realValue];
    NSString *userPhone = [self.userPhone realValue];
    NSString *area = self.userArea.titleLabel.text;
    NSString *detailAddr = [self.userDetailAddress realValue];
    
    if (userName.length > 0 && [ValidatePhoneNumber checkPhoneNumberInput:userPhone] && area.length > 0 && detailAddr.length > 0) {
        if (self.editTag == 1) {
            [ReceiveAddressModelView updateUserAddressWithName:userName phone:userPhone userArea:area userAddress:detailAddr isDefault:self.model.isDefaultAddress addrId:self.model.id];
        } else {
            [ReceiveAddressModelView  addUserAddressWithName:userName phone:userPhone userArea:area userAddress:detailAddr isDefault:0];
        }
        
        
        self.view.userInteractionEnabled = NO;
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            if (self.delegate && [self.delegate respondsToSelector:@selector(refreshReceiveData)]) {
                [self.delegate refreshReceiveData];
            }
            
            [SVProgressHUD dismiss];
            self.view.userInteractionEnabled = YES;
        });
        
    } else if (userName.length == 0) {
        [self.view makeToast:@"请输入收货人名称" duration:3.0 position:@"top"];
    } else if (userPhone.length == 0 || [ValidatePhoneNumber checkPhoneNumberInput:userPhone] == NO) {
        [self.view makeToast:@"手机号格式不正确" duration:3.0 position:@"top"];
    } else if (area.length == 0) {
        [self.view makeToast:@"请选择区域" duration:3.0 position:@"top"];
    } else if (detailAddr.length == 0) {
        [self.view makeToast:@"请输入详细地址" duration:3.0 position:@"top"];
    }
}

- (void)backAction {
    NSString *userName = self.userName.text;
    NSString *userPhone = self.userPhone.text;
    NSString *area = self.userArea.titleLabel.text;
    NSString *detailAddr = self.userDetailAddress.text;
    if (userName.length > 0 || userPhone.length > 0 || area.length > 0 || detailAddr.length > 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有填写的地址信息没有保存，确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:NULL];
        [alert addAction:sureAlert];
        [alert addAction:cancelAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - privete methods
- (void)cancelLocatePicker {
    [self.locatePicker dismiss];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}



@end
