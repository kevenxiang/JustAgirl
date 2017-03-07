//
//  WriteContentViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/11.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "WriteContentViewController.h"
#import "ImageAndDeleteBtn.h"
#import "KeyboardTool.h"
#import "DBModelViewsHeader.h"
#import "ScanImageViewController.h"

#import "PECropViewController.h"

#import "UIImage+Compression.h"
#import "UIView+Toast.h"


#define kImageWidthSpace     15
#define kImageHeightSpace    8
#define kTextViewHeight      120
#define kImageHeight         80
#define kImageWidth          ((kScreenWidth - kImageWidthSpace * 4)/3.0f)
#define kKeyToolHeight       45

@interface WriteContentViewController () <UITextViewDelegate, ImageAndDeleteBtnDelegate, KeyboardToolDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIScrollView *tScrollView;
    UITextField *titleField;
    UITextView *tTextView;
    KeyboardTool *keyTool;
    NSInteger keyBoardHeight;
    
    NSMutableArray *imageArray;
    NSMutableArray *dataArray;
}

@property (nonatomic, strong) DiaryViewModel *dairyViewModel;

@end

@implementation WriteContentViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navTitle.length > 0) {
        self.navigationItem.title = self.navTitle;
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        self.navigationItem.title = [dateFormatter stringFromDate:[NSDate date]];
    }
    
    kWEAKSELF;
    [weakSelf setLeftBarButtonWithTitle:@"取消" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        [weakSelf.view endEditing:YES];
        if ([titleField realValue].length > 0 || tTextView.text.length > 0 || imageArray.count > 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你写的内容还没有保存呢，确定要取消吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf dismissViewControllerAnimated:YES completion:NULL];
                });
            }];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"不取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:cancel];
            [alert addAction:sure];
            [self presentViewController:alert animated:YES completion:NULL];
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
            });
        }
        
    }];
    
    if (self.contentType == WriteContentType_Share) {
        //如果用户登录过，就是发表
        
        //如果未登录，就是保存
    }
    
    [weakSelf setRightBarButtonWithTitle:@"保存" titleColor:[UIColor whiteColor] withBlock:^(NSInteger tag) {
        [weakSelf.view endEditing:YES];
        if (self.contentType == WriteContentType_Diary) {
            ;
            if (tTextView.text.length == 0) {
                [self.view makeToast:@"写点内容吧！" duration:3.0 position:@"top"];
                return;
            }
            if ([DiaryViewModel saveDiaryWithTitle:[titleField realValue] content:tTextView.text imgAray:imageArray creatTime:_navTitle]) {
                
                self.view.userInteractionEnabled = NO;
                [self.view makeToast:@"保存成功!" duration:3.0 position:@"top"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.view.userInteractionEnabled = YES;
                    [weakSelf dismissViewControllerAnimated:YES completion:NULL];
                });
            } else {
                [self.view makeToast:@"抱歉，保存失败!" duration:3.0 position:@"top"];
            }
            
        } else if (self.contentType == WriteContentType_Share) {
            if (tTextView.text.length == 0) {
                [self.view makeToast:@"写点内容吧！" duration:3.0 position:@"top"];
                return;
            }
            NSInteger nowTime = [[NSDate date] timeIntervalSince1970];
            NSInteger shareType;//1为图片类型，2为文本类型，3为链接类型
            if (imageArray.count > 0) {
                shareType = 1;
            } else {
                shareType = 2;
            }
            if ([MyShareViewModel saveShareDataWithTitle:[titleField realValue] content:tTextView.text imageAry:imageArray createTime:nowTime publishTag:0 shareType:shareType]) {
                self.view.userInteractionEnabled = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserWriteShareSuccessNotification object:nil userInfo:nil];
                [self.view makeToast:@"保存成功!" duration:3.0 position:@"top"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.view.userInteractionEnabled = YES;
                    [weakSelf dismissViewControllerAnimated:YES completion:NULL];
                });
                
            } else {
                [self.view makeToast:@"抱歉，保存失败!" duration:3.0 position:@"top"];
            }
        }
        
    }];
    
    tScrollView = [[UIScrollView alloc] init];
    tScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    tScrollView.showsVerticalScrollIndicator = NO;
    tScrollView.showsHorizontalScrollIndicator = NO;
    tScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:tScrollView];
    
    titleField = [[UITextField alloc] init];
    titleField.frame = CGRectMake(10, 5, kScreenWidth - 20, 30);
    titleField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    titleField.font = [UIFont boldSystemFontOfSize:15];
    titleField.placeholder = @"请输入标题";
    [tScrollView addSubview:titleField];
    
    tTextView = [[UITextView alloc] init];
    tTextView.frame = CGRectMake(10, 35, kScreenWidth - 20, kTextViewHeight);
    tTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tTextView.font = [UIFont systemFontOfSize:15];
    [tTextView becomeFirstResponder];
    [tScrollView addSubview:tTextView];
    
    imageArray = [[NSMutableArray alloc] init];
    
    keyTool = [[KeyboardTool alloc] init];
    keyTool.frame = CGRectMake(0, [UIScreen screenHeight], [UIScreen screenWidth], kKeyToolHeight);
    keyTool.delegate = self;
    [self.view addSubview:keyTool];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *text = textView.text;
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]} context:nil];
    CGFloat textViewHeight = (CGFloat)fmaxf(kTextViewHeight, rectToFit.size.height);
    
     CGFloat scrollHeight = (CGFloat)fmaxf(kScreenHeight, kScreenHeight + rectToFit.size.height - 120);
    tScrollView.contentSize = CGSizeMake(kScreenWidth, scrollHeight);
    
    if (textViewHeight > 240) {
        [tScrollView scrollRectToVisible:CGRectMake(0, -240, kScreenWidth, kScreenHeight) animated:YES];
         tTextView.frame = CGRectMake(tTextView.frame.origin.x, tTextView.frame.origin.y, tTextView.frame.size.width, 240);
        for (NSInteger i = 0; i < imageArray.count; i++) {
            NSInteger index = i % 3;
            NSInteger page = i / 3;
            UIView *mView = [self.view viewWithTag:100 + i];
            mView.frame = CGRectMake(index * (kImageWidth + kImageWidthSpace) + kImageWidthSpace, page * (kImageHeight + kImageHeightSpace) + 240 + 50, kImageWidth, kImageHeight);
        }
    } else {
        tTextView.frame = CGRectMake(tTextView.frame.origin.x, tTextView.frame.origin.y, tTextView.frame.size.width, textViewHeight);
        for (NSInteger i = 0; i < imageArray.count; i++) {
            NSInteger index = i % 3;
            NSInteger page = i / 3;
      
            UIView *mView = [self.view viewWithTag:100 + i];
            mView.frame = CGRectMake(index * (kImageWidth + kImageWidthSpace) + kImageWidthSpace, page * (kImageHeight + kImageHeightSpace) + textViewHeight + 50, kImageWidth, kImageHeight);
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *text = textView.text;
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(kScreenWidth - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]} context:nil];
    CGFloat textViewHeight = (CGFloat)fmaxf(120.0f, rectToFit.size.height);
    
    CGFloat scrollHeight = (CGFloat)fmaxf(kScreenHeight, textViewHeight + 120 + 200);
    tScrollView.contentSize = CGSizeMake(kScreenWidth, scrollHeight);
    tTextView.frame = CGRectMake(tTextView.frame.origin.x, tTextView.frame.origin.y, tTextView.frame.size.width, textViewHeight);
    for (NSInteger i = 0; i < imageArray.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
    
        UIView *mView = [self.view viewWithTag:100 + i];
        mView.frame = CGRectMake(index * (kImageWidth + kImageWidthSpace) + kImageWidthSpace, page * (kImageHeight + kImageHeightSpace) + textViewHeight + 20, kImageWidth, kImageHeight);
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
    UIImage *newImage = [croppedImage imageCompressForSize:croppedImage targetSize:CGSizeMake(1200, 1200)];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSInteger nowTime = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *imgName;
    if (self.contentType == WriteContentType_Diary) {
        
        imgName = [NSString stringWithFormat:@"%lddiaryImg.png",nowTime];
        
    } else if (self.contentType == WriteContentType_Share) {
        
        imgName = [NSString stringWithFormat:@"%ldshareImg.png",nowTime];
    }

    [FCFileManager createFileAtPath:imgName withContent:imageData];
    [imageArray addObject:imgName];
    [self setImages];
    [tTextView becomeFirstResponder];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - ImageAndDeleteBtnDelegate
- (void)deleteBtnClicked:(ImageAndDeleteBtn *)img {
    NSInteger tag = img.tag - 100;
    [imageArray removeObjectAtIndex:tag];
    [self setImages];
}

#pragma mark - KeyboardToolDelegate
- (void)albumBtnAction {
    [self showPhotoLibrary];
}

- (void)cameraBtnAction {
    [self showCamera];
}

- (void)dismissKeyBtnAction {
    [self.view endEditing:YES];
}

#pragma mark - event responds
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyBoardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:0.1 animations:^{
        keyTool.frame = CGRectMake(0, [UIScreen screenHeight] - keyBoardHeight - kKeyToolHeight - 64, [UIScreen screenWidth], kKeyToolHeight);
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:0.1 animations:^{
        keyTool.frame = CGRectMake(0, [UIScreen screenHeight] + 50, [UIScreen screenWidth], kKeyToolHeight);
    }];
}

- (void)imageAndDeleteBtnTap:(UITapGestureRecognizer *)sender {
    ImageAndDeleteBtn *imgView = (ImageAndDeleteBtn *)sender.view;
    ScanImageViewController *scanImageCtr = [[ScanImageViewController alloc] init];
    scanImageCtr.scanImage = imgView.image;
    [self.navigationController pushViewController:scanImageCtr animated:YES];
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

#pragma mark - getting and setting
- (void)setImages {
    for (UIView *imgView in tScrollView.subviews) {
        if ([imgView isKindOfClass:[ImageAndDeleteBtn class]]) {
            [imgView removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        ImageAndDeleteBtn *imgView = [[ImageAndDeleteBtn alloc] init];
        imgView.delegate = self;
        imgView.tag = 100 + i;
        NSData *imageData = [FCFileManager readFileAtPathAsData:imageArray[i]];
        UIImage *image = [UIImage imageWithData:imageData];
        imgView.image = image;
        //水平间距为15，垂直间距为10
        imgView.frame = CGRectMake(index * (kImageWidth + kImageWidthSpace) + kImageWidthSpace, page * (kImageHeight + kImageHeightSpace) + 170, kImageWidth, kImageHeight);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        [tScrollView addSubview:imgView];
        
        UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAndDeleteBtnTap:)];
        imgTap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:imgTap];
    }

}

@end
