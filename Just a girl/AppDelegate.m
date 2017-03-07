//
//  AppDelegate.m
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "AppDelegate.h"

//控制器
#import "MainPageViewController.h"
#import "PrivacyViewController.h"
#import "LoveSelfViewController.h"
#import "MineViewController.h"

//全局定义
#import "DefineConfig.h"

//第三方库
#import "IQKeyboardManager.h"
#import "DBFramework.h"
#import <Bugly/Bugly.h>//腾讯崩溃报告

//model
#import "DiaryModel.h"

//数据库处理层
#import "ReceiveAddressModel.h"

NSString * const BUGLY_APP_ID = @"900038013";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setNavigationBarStyle];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //控制器
    [self showMainViewController];
    [self.window makeKeyAndVisible];
    
    //键盘自适应
    [self initKeyboard];
    //初始化数据库
    [self initDb];
    
    //安装腾讯崩溃报告
    [self setupBugly];
    
    
    
    /*
     //扩展用的代码
    //初始化一个供App Groups使用的NSUserDefaults对象
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.girlShare"];
    //读取数据
    NSLog(@"扩展==%@", [userDefaults valueForKey:@"share-url"]);
     */
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"222222222" object:nil userInfo:nil];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private methods
//键盘弹出时view自动移动高度
- (void)initKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.shouldResignOnTouchOutside = NO;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    manager.shouldShowTextFieldPlaceholder = NO;
}

//初始化数据库
- (void)initDb {
    NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DB"];
    NSString *dbFilePath = [NSString stringWithFormat:@"%@/db.db", dbPath];
    [DBService shareInstance].dbPath = dbFilePath;
    [DBService shareInstance].dbPathUpdate = YES;
     NSLog(@"用户数据库路径:%@", dbFilePath);
    
    BOOL isDir;
    NSFileManager *filemanage = [NSFileManager defaultManager];
    BOOL exit = [filemanage fileExistsAtPath:dbPath isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [DiaryModel createTable];
    [ReceiveAddressModel createTable];
    
}

#pragma mark - getting and setting
//设置导航栏和状态栏的样式
- (void)setNavigationBarStyle {
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor magentaColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kRGBCOLOR(235, 72, 139),NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)showMainViewController {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    MainPageViewController *main = [[MainPageViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    
    PrivacyViewController *privacy = [[PrivacyViewController alloc] init];
    UINavigationController *privacyNav = [[UINavigationController alloc] initWithRootViewController:privacy];
    
    LoveSelfViewController *loveSelf = [[LoveSelfViewController alloc] init];
    UINavigationController *loveSelfNav = [[UINavigationController alloc] initWithRootViewController:loveSelf];
    
    MineViewController *mine = [[MineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mine];
    
    _tabBarController = [[CYLTabBarController alloc] init];
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"首页-1",
                            CYLTabBarItemSelectedImage : @"首页"
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"购物",
                            CYLTabBarItemImage : @"私密",
                            CYLTabBarItemSelectedImage : @"私密-1"
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"发现",
                            CYLTabBarItemSelectedImage : @"发现-1"
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"我的",
                            CYLTabBarItemSelectedImage : @"我的-1"
                            };
    

    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4,
                                       ];
    _tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    _tabBarController.delegate = (id<UITabBarControllerDelegate>) self;
    _tabBarController.tabBar.selectedImageTintColor = [UIColor magentaColor];
    
    
    /**
     *  这里可以做自定义主题的设置
     */
//    _tabBarController.tabBar.selectedImageTintColor = [UIColor whiteColor];
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
//    backView.backgroundColor = [UIColor darkGrayColor];
//    [_tabBarController.tabBar insertSubview:backView atIndex:0];
//    _tabBarController.tabBar.opaque = YES;
    
    
    [_tabBarController setViewControllers:@[
                                            mainNav,
                                            privacyNav,
                                            loveSelfNav,
                                            mineNav,
                                            ]];
    self.window.rootViewController = _tabBarController;

}

//安装腾讯崩溃报告
- (void)setupBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
#if DEBUG 
    config.debugMode = YES;
#endif
    
    config.reportLogLevel = BuglyLogLevelWarn;
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 1.5;
    config.channel = @"Bugly";
    [Bugly startWithAppId:BUGLY_APP_ID
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"App"];
//    [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
    
}

- (void)testLogOnBackground {
    int cnt = 0;
    while (1) {
        cnt++;
        
        switch (cnt % 5) {
            case 0:
                BLYLogError(@"Test Log Print %d", cnt);
                break;
            case 4:
                BLYLogWarn(@"Test Log Print %d", cnt);
                break;
            case 3:
                BLYLogInfo(@"Test Log Print %d", cnt);
                BLYLogv(BuglyLogLevelWarn, @"BLLogv: Test", NULL);
                break;
            case 2:
                BLYLogDebug(@"Test Log Print %d", cnt);
                BLYLog(BuglyLogLevelError, @"BLLog : %@", @"Test BLLog");
                break;
            case 1:
            default:
                BLYLogVerbose(@"Test Log Print %d", cnt);
                break;
        }
        
        // print log interval 1 sec.
        sleep(1);
    }
}


@end
