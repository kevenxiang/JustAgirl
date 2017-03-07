//
//  MineViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "PersonCenterImageAndTitleCell.h"
#import "WriteContentViewController.h"
#import "WriteDiaryViewController.h"
#import "MyShareViewController.h"
#import "MyPublishedShareCtr.h"
#import "MenstruationDateCtr.h"
#import "ConstellationCtr.h"
#import "ShoppingCartCtr.h"
#import "MyCollectViewController.h"
#import "ReceiveAddressCtr.h"
#import "LoginViewController.h"

static CGFloat const kHeadImgHeight = 200.0f; //顶部下拉图片的高度

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *mTableView;
    UIImageView *headImgView;
    UIImageView *userHeadImgView;
    UILabel *userNameLabel;
    UIButton *settingBtn;
    NSArray *titleArray;
    NSArray *imageArray;
    UITapGestureRecognizer *loginTap;
}

@end

@implementation MineViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addMainUI];
//    titleArray = @[@"写分享", @"写日记",  @"我的分享", @"我的收藏",@"算周期", @"星座", @"购物车", @"常用收货地址"];
//    imageArray = @[@"写分享", @"写日记", @"我的分享", @"我的收藏", @"算周期", @"星座", @"购物车", @"常用收货地址"];
    
    
    //@"算周期", @"星座",这两个模块先不要了
    titleArray = @[@"写分享", @"写日记",  @"我的分享", @"我的收藏", @"购物车", @"常用收货地址"];
    imageArray = @[@"写分享", @"写日记", @"我的分享", @"我的收藏", @"购物车", @"常用收货地址"];
    
    //安装用户登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kUserLoginSuccessNotification object:nil];
    //安装用户退出登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess:) name:kUserLogoutSuccessNotification object:nil];
    //安装用户修改信息成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userModifySuccess) name:kUserModifyInfoSuccessNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    }
    
//    else if (section == 2) {
//        return 2;
//    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat viewHeight = 0.1;
        UIView *tView = [[UIView alloc] init];
        tView.frame = CGRectMake(0, 0, tableView.frame.size.width, viewHeight);
        tView.backgroundColor = [UIColor clearColor];
        return tView;
    } else {
        UIView *tView = [[UIView alloc] init];
        tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
        tView.backgroundColor = [UIColor clearColor];
        return tView;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *tView = [[UIView alloc] init];
    tView.frame = CGRectMake(0, 0, tableView.frame.size.width, 5);
    tView.backgroundColor = [UIColor clearColor];
    return tView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat viewHeight = 0.1;
        return viewHeight;
    } else {
        return 5.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *UserCellID = @"UserCellID";
    PersonCenterImageAndTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:UserCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonCenterImageAndTitleCell" owner:nil options:nil] lastObject];
    }
    
    if (indexPath.section == 0) {
        [cell setCellDataWithTitle:titleArray[indexPath.row] imageName:imageArray[indexPath.row]];
    } else if (indexPath.section == 1) {
        [cell setCellDataWithTitle:titleArray[indexPath.row + 2] imageName:imageArray[indexPath.row + 2]];
    } else if (indexPath.section == 2) {
        [cell setCellDataWithTitle:titleArray[indexPath.row + 4] imageName:imageArray[indexPath.row + 4]];
    }
//    else if (indexPath.section == 3) {
//        [cell setCellDataWithTitle:titleArray[indexPath.row + 6] imageName:imageArray[indexPath.row + 6]];
//    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//写分享
            if ([ShareValue instance].user.token.length > 0) {
                MyShareViewController *tShare = [[MyShareViewController alloc] init];
                tShare.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tShare animated:YES];
            } else {
                [self showLoginVC];
            }
           
            
        } else if (indexPath.row == 1) {//写日记
            
            if ([ShareValue instance].user.token.length > 0) {
                WriteDiaryViewController *tWriteDiaryViewController = [[WriteDiaryViewController alloc] init];
                tWriteDiaryViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tWriteDiaryViewController animated:YES];
            } else {
                [self showLoginVC];
            }
            
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//我的分享
            
            if ([ShareValue instance].user.token.length > 0) {
                MyPublishedShareCtr *tMyPublishedShareCtr = [[MyPublishedShareCtr alloc] init];
                tMyPublishedShareCtr.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tMyPublishedShareCtr animated:YES];
            } else {
                [self showLoginVC];
            }
            
        } else if (indexPath.row == 1) {//我的收藏
            if ([ShareValue instance].user.token.length > 0) {
                MyCollectViewController *tMyCollectViewController = [[MyCollectViewController alloc] init];
                tMyCollectViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tMyCollectViewController animated:YES];
            } else {
                [self showLoginVC];
            }
        }
    }
    
    /*
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {//算周期
            
            if ([ShareValue instance].user.token.length > 0) {
                MenstruationDateCtr *tMenstruationDateCtr = [[MenstruationDateCtr alloc] init];
                tMenstruationDateCtr.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tMenstruationDateCtr animated:YES];
            } else {
                [self showLoginVC];
            }

            
        } else if (indexPath.row == 1) {//星座
            
            ConstellationCtr *tConstellationCtr = [[ConstellationCtr alloc] init];
            tConstellationCtr.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tConstellationCtr animated:YES];
        }
    }
     */
    
    if (indexPath.section == 2) {
        if(indexPath.row == 0) {//购物车
            
            if ([ShareValue instance].user.token.length > 0) {
                ShoppingCartCtr *tShoppingCartCtr = [[ShoppingCartCtr alloc] init];
                tShoppingCartCtr.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tShoppingCartCtr animated:YES];
            } else {
                [self showLoginVC];
            }
            
        } else if (indexPath.row == 1) {//收货地址
            
            if ([ShareValue instance].user.token.length > 0) {
                ReceiveAddressCtr *tReceiveAddressCtr = [[ReceiveAddressCtr alloc] init];
                tReceiveAddressCtr.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tReceiveAddressCtr animated:YES];
            } else {
                [self showLoginVC];
            }
        }
            
    }
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = kHeadImgHeight + offsetY;
    if (offsetH < 0) {
        CGRect frame = headImgView.frame;
        frame.size.height = kHeadImgHeight - offsetH;
        frame.origin.y = -kHeadImgHeight + offsetH;
        headImgView.frame = frame;
    }
}

#pragma mark - event responds
- (void)settingBtnAction {
    
    if ([ShareValue instance].user.token.length > 0) {
        SettingViewController *setting = [[SettingViewController alloc] init];
        setting.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setting animated:YES];
    } else {
        [self showLoginVC];
    }
}

- (void)loginTapAction {
    [self showLoginVC];
}

- (void)loginSuccess:(NSNotification *)userInfo {
    [self refreshUserNameAndHeadImg];
}

- (void)logoutSuccess:(NSNotification *)userinfo {
    [self refreshUserNameAndHeadImg];
}

- (void)userModifySuccess {
    [self refreshUserNameAndHeadImg];
}

#pragma mark - private methods
- (void)showLoginVC {
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)refreshUserNameAndHeadImg {
    if ([ShareValue instance].user.token.length > 0) {
        [userNameLabel removeGestureRecognizer:loginTap];
        if ([ShareValue instance].user.username.length > 0) {
            userNameLabel.text = [ShareValue instance].user.username;
        } else {
            userNameLabel.text = [ShareValue instance].user.mobile;
        }
        
    } else {
        userNameLabel.text = @"请登录";
        if (!loginTap) {
            loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapAction)];
            loginTap.numberOfTapsRequired = 1;
        }
        [userNameLabel addGestureRecognizer:loginTap];
    }
    
    
    UIImage *image;
    if ([ShareValue instance].user.headImg.length > 0) {
        NSData *imageData = [FCFileManager readFileAtPathAsData:[ShareValue instance].user.headImg];
        image = [UIImage imageWithData:imageData];
        
    }
    if (image == nil) {
        image = [UIImage imageNamed:@"navBgImg"];
    }
    
    headImgView.image = image;

}

#pragma mark - getting and setting
- (void)addMainUI {
    //用户图像
    headImgView = [[UIImageView alloc] init];
    headImgView.userInteractionEnabled = YES;
    headImgView.frame = CGRectMake(0, -kHeadImgHeight, kScreenWidth, kHeadImgHeight);
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    headImgView.layer.masksToBounds = YES;
    //判断用户是否上传图像，上传了图像就用用户的图像，没有就用默认的
    UIImage *image;
    if ([ShareValue instance].user.headImg.length > 0) {
        NSData *imageData = [FCFileManager readFileAtPathAsData:[ShareValue instance].user.headImg];
        image = [UIImage imageWithData:imageData];
        
    }
    if (image == nil) {
        image = [UIImage imageNamed:@"navBgImg"];
    }
    
    headImgView.image = image;
    
    //用户名称
    userNameLabel = [[UILabel alloc] init];
    userNameLabel.frame = CGRectMake(10, kHeadImgHeight - 40, kScreenWidth - 20, 40);
    userNameLabel.font = [UIFont boldSystemFontOfSize:15];
    if ([ShareValue instance].user.token.length > 0) {
        if ([ShareValue instance].user.username.length > 0) {
            userNameLabel.text = [ShareValue instance].user.username;
        } else {
            userNameLabel.text = [ShareValue instance].user.mobile;
        }
        
    } else {
        userNameLabel.text = @"请登录";
        if (!loginTap) {
            loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapAction)];
            loginTap.numberOfTapsRequired = 1;
        }
        [userNameLabel addGestureRecognizer:loginTap];
    }
    
    userNameLabel.textColor = [UIColor whiteColor];
    [headImgView addSubview:userNameLabel];
    userNameLabel.userInteractionEnabled = YES;
   
    
    
    //设置按钮
    settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kScreenWidth - 60, 30, 22, 22);
    [settingBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [headImgView addSubview:settingBtn];
    
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.separatorColor = [UIColor clearColor];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.contentInset = UIEdgeInsetsMake(kHeadImgHeight, 0, 0, 0);
    [self.view addSubview:mTableView];
    [mTableView addSubview:headImgView];
}

@end
