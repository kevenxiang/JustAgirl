//
//  LoginViewController.m
//  Just a girl
//
//  Created by xiang on 16/7/19.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "LoginViewController.h"
#import "ReactiveCocoa.h"
#import "ValidatePhoneNumber.h"
#import "LoginViewModel.h"
#import "RegisterViewController.h"
#import "FindPsViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet BaseButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPsBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (nonatomic, strong) LoginViewModel *viewModel;


@end

@implementation LoginViewController

#pragma mark - life cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewModel = [LoginViewModel new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    kWEAKSELF;
    [self setLeftBarButtonWithTitle:@"取消" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        [weakSelf.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        });
    }];
    
    
    //添加监听事件
    [self addListenTarget];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - event responds
- (IBAction)forgetPassWordAction:(id)sender {
    FindPsViewController *find = [[FindPsViewController alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}

- (IBAction)registerAction:(id)sender {
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark - private methods 
- (void)addListenTarget {
    RACSignal *validPhoneSignal = [self.phoneTextField.rac_textSignal map:^id(NSString *value) {
        value = [self.phoneTextField realValue];
        return @([ValidatePhoneNumber checkPhoneNumberInput:value]);
    }];
    
    RAC(self.phoneTextField, textColor) = [validPhoneSignal map:^id(id value) {
        if ([value boolValue]) {
            return [UIColor blackColor];
        } else {
            return [UIColor redColor];
        }
    }];
    
    @weakify(self);
    RAC(self.viewModel, username) = self.phoneTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    [[self.viewModel.loginCommand.executionSignals flattenMap:^(RACSignal *execution) {
        // Sends RACUnit after the execution completes.
        return [[execution ignoreValues] concat:[RACSignal return:RACUnit.defaultUnit]];
    }] subscribeNext:^(id _) {
        @strongify(self);
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            NSInteger nowTime = [[NSDate date] timeIntervalSince1970];
            UserModel *user = [[UserModel alloc] init];
            user.uid = [[NSString stringWithFormat:@"%@%ld", self.phoneTextField.text, nowTime] md5String];
            user.token = [[NSString stringWithFormat:@"%@%ld", self.phoneTextField.text, nowTime] md5String];
            user.username = @"";
            user.mobile = self.phoneTextField.text;
            user.email = @"";
            [[ShareValue instance] setUser:user];
            
            [self dismissViewControllerAnimated:YES completion:^{
                //发送用户登录成功以后的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessNotification
                                                                    object:nil
                                                                  userInfo:nil];
            }];
        });
    }];
}

@end
