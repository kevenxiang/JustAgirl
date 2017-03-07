//
//  ModifyInfoViewController.m
//  Just a girl
//
//  Created by xiang on 16/8/18.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ModifyInfoViewController.h"

@interface ModifyInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ModifyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改昵称";
    
    self.textFiled.text = self.originalNickName;
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setTitle:@"完成" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kRightMargin;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem, space, nil];
    
    [self.textFiled addTarget:self action:@selector(textFileldChange:) forControlEvents:UIControlEventEditingChanged];
    
    RACSignal *nickNameSignal = [self.textFiled.rac_textSignal map:^id(id value) {
        return @([self checkNickName]);
    }];
    
    RAC(rightBarButton, titleLabel.textColor) = [nickNameSignal map:^id(id value) {
        return [UIColor whiteColor];
    }];
    
    
    rightBarButton.rac_command = [[RACCommand alloc] initWithEnabled:nickNameSignal signalBlock:^RACSignal *(id input) {
        
        UserModel *user = [ShareValue instance].user;
        user.username = self.textFiled.text;
        [[ShareValue instance] setUser:user];
        
        //修改信息成功的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserModifyInfoSuccessNotification object:nil userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
        
        return [RACSignal empty];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textFileldChange:(UITextField *)textF {
    if (textF.text.length >= 30) {
        self.textFiled.text = [textF.text substringToIndex:30];
    }
}

- (BOOL)checkNickName {
    NSString *input = [self.textFiled realValue];
    if (input.length > 0 && ![input isEqualToString:self.originalNickName] && input.length < 30) {
        return YES;
    }
    
    return NO;
}

@end
