//
//  SettingViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/11.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "SettingViewController.h"
#import "TitleRightImageCell.h"
#import "TitleRightContentCell.h"
#import "TitleCell.h"
#import "PECropViewController.h"
#import "UIImage+Compression.h"
#import "ModifyInfoViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PECropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation SettingViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人设置";
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataNotification) name:kUserModifyInfoSuccessNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70.0f;
    } else {
        return 50.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *HeadImgCellID = @"HeadImgCellID";
        TitleRightImageCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadImgCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleRightImageCell" owner:nil options:nil] lastObject];
        }
//        NSURL *url = [NSURL URLWithString:[ShareValue instance].user.img];
//        [cell.imgView getImageWithUrl:url placeHolder:[UIImage imageNamed:@"头像"]];
        cell.titleLabel.text = @"头像";
        
        UIImage *image;
        if ([ShareValue instance].user.headImg.length > 0) {
            NSData *imageData = [FCFileManager readFileAtPathAsData:[ShareValue instance].user.headImg];
            image = [UIImage imageWithData:imageData];

        }
        if (image == nil) {
            image = [UIImage imageNamed:@"头像"];
        }
        cell.imgView.image = image;
        
        return cell;
        
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        NSArray *titleArray = @[@"昵称", @"手机号码"];
        static NSString *UserInfoCellID = @"UserInfoCellID";
        TitleRightContentCell *cell = [tableView dequeueReusableCellWithIdentifier:UserInfoCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleRightContentCell" owner:nil options:nil] lastObject];
        }
        
        cell.titleLabel.text = titleArray[indexPath.row - 1];
        if (indexPath.row == 1) {
            cell.contentLabel.text = [ShareValue instance].user.username;
        }
        if (indexPath.row == 2) {
            cell.contentLabel.text = [ShareValue instance].user.mobile;
        }
        
        return cell;
    } else {
        NSArray *titleArray = @[@"修改密码"];
        static NSString *TitleCellID = @"TitleCellID";
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCellID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleCell" owner:nil options:nil] lastObject];
        }
        
        cell.titleLbel.text = titleArray[indexPath.row - 3];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *manager = [FCFileManager pathForDocumentsDirectory];
    NSLog(@"manager=========:%@", manager);
   
    
    switch (indexPath.row) {
        case 0:
        {
            [self selectImage];
           
            break;
        }
            
        case 1:
        {
            ModifyInfoViewController *modify = [[ModifyInfoViewController alloc] init];
            modify.originalNickName = [ShareValue instance].user.username;
            [self.navigationController pushViewController:modify animated:YES];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = image;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:navigationController animated:YES completion:NULL];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - PECropViewControllerDelegate
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    [controller dismissViewControllerAnimated:YES completion:NULL];
    //得到裁剪后的图片
    UIImage *newImage = [croppedImage imageCompressForSize:croppedImage targetSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    NSData *imageData = UIImagePNGRepresentation(newImage);

    UserModel *user = [ShareValue instance].user;
    user.headImg = user.uid;
    [FCFileManager removeItemAtPath:user.headImg];
    [FCFileManager createFileAtPath:user.headImg withContent:imageData];
    [[ShareValue instance] setUser:user];
    [self.mTableView reloadData];
    
    //修改信息成功的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserModifyInfoSuccessNotification object:nil userInfo:nil];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - event responds
- (IBAction)logoutBtnAction:(id)sender {
    UserModel *user = [ShareValue instance].user;
    user.token = @"";
    user.headImg = @"";
    [[ShareValue instance] setUser:user];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogoutSuccessNotification object:nil userInfo:nil];
    
    [self.view makeToast:@"退出登录成功" duration:3.0 position:@"top"];
    self.view.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.view.userInteractionEnabled = YES;
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)refreshDataNotification {
    [self.mTableView reloadData];
}

#pragma mark - private methods
//显示相机
- (void)showCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:controller animated:YES completion:NULL];
}

//显示相册
- (void)showPhotoLibrary {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)selectImage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoLibrary];
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCamera];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
