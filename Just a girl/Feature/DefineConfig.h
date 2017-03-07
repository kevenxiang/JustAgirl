//
//  DefineConfig.h
//  KouDaiDuoBao
//
//  Created by 向琼 on 16/3/30.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#ifndef DefineConfig_h
#define DefineConfig_h

#define kAppName                    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]
#define kAppVersion                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAppBuildVersion            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define kScreenBounds               [[UIScreen mainScreen] bounds]
#define kScreenWidth                kScreenBounds.size.width
#define kScreenHeight               kScreenBounds.size.height

#define kAppDelegate                ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#ifdef DEBUG
#define DLog(fmt, ...)              NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define kSystemVersion              [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIOS7OrLater                (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
#define kIOS8OrLater                (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

#define kUSER_DEFAULT               [NSUserDefaults standardUserDefaults]

#define kWEAKSELF                   __weak __typeof(self) weakSelf = self

#pragma mark - color functions

#define kRGBCOLOR(r,g,b)            [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRGBACOLOR(r,g,b,a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kUIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define kIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//以下是Category的内置成员变量方法
#define CATEGORY_PROPERTY_GET(type, property) - (type) property { return objc_getAssociatedObject(self, @selector(property)); }
#define CATEGORY_PROPERTY_SET(type, property, setter) - (void) setter (type) property { objc_setAssociatedObject(self, @selector(property), property, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
#define CATEGORY_PROPERTY_GET_SET(type, property, setter) CATEGORY_PROPERTY_GET(type, property) CATEGORY_PROPERTY_SET(type, property, setter)

#define CATEGORY_PROPERTY_GET_NSNUMBER_PRIMITIVE(type, property, valueSelector) - (type) property { return [objc_getAssociatedObject(self, @selector(property)) valueSelector]; }
#define CATEGORY_PROPERTY_SET_NSNUMBER_PRIMITIVE(type, property, setter, numberSelector) - (void) setter (type) property { objc_setAssociatedObject(self, @selector(property), [NSNumber numberSelector: property], OBJC_ASSOCIATION_RETAIN_NONATOMIC); }

#define CATEGORY_PROPERTY_GET_UINT(property) CATEGORY_PROPERTY_GET_NSNUMBER_PRIMITIVE(unsigned int, property, unsignedIntValue)
#define CATEGORY_PROPERTY_SET_UINT(property, setter) CATEGORY_PROPERTY_SET_NSNUMBER_PRIMITIVE(unsigned int, property, setter, numberWithUnsignedInt)
#define CATEGORY_PROPERTY_GET_SET_UINT(property, setter) CATEGORY_PROPERTY_GET_UINT(property) CATEGORY_PROPERTY_SET_UINT(property, setter)

#define CATEGORY_PROPERTY_GET_INT(type, property) CATEGORY_PROPERTY_GET_NSNUMBER_PRIMITIVE(type, property, intValue)
#define CATEGORY_PROPERTY_SET_INT(type, property, setter) CATEGORY_PROPERTY_SET_NSNUMBER_PRIMITIVE(type, property, setter, numberWithInt)
#define CATEGORY_PROPERTY_GET_SET_INT(type, property, setter) CATEGORY_PROPERTY_GET_INT(type, property) CATEGORY_PROPERTY_SET_INT(type, property, setter)

#define CATEGORY_PROPERTY_GET_BOOL(type, property) CATEGORY_PROPERTY_GET_NSNUMBER_PRIMITIVE(type, property, boolValue)
#define CATEGORY_PROPERTY_SET_BOOL(type, property, setter) CATEGORY_PROPERTY_SET_NSNUMBER_PRIMITIVE(type, property, setter, numberWithBool)
#define CATEGORY_PROPERTY_GET_SET_BOOL(type, property, setter) CATEGORY_PROPERTY_GET_INT(type, property) CATEGORY_PROPERTY_SET_INT(type, property, setter)


//系统主题色
#define kThemeColor                               kRGBCOLOR(235, 72, 139)

//第一个安装APP的key
#define kFirstKey                                 @"kFirstKey"

//用户未注册的情况下，默认的用户id
#define kDefaultUserId                            @"defaultUserId"

//用户登录成功以后的通知
#define kUserLoginSuccessNotification             @"kUserLoginSuccessNotification"
//用户退出登录的通知
#define kUserLogoutSuccessNotification            @"kUserLogoutSuccessNotification"
//用户修改信息成功的通知
#define kUserModifyInfoSuccessNotification        @"kUserModifyInfoSuccessNotification"
//用户写分享数据完成的通知
#define kUserWriteShareSuccessNotification        @"kUserWriteShareSuccessNotification"

//编写内容的类型
typedef NS_ENUM(NSUInteger, WriteContentType) {
    WriteContentType_Diary = 0, //写日记
    WriteContentType_Share,     //写分享
};

//分享的内容类型
typedef NS_ENUM(NSUInteger, ShareContentType) {
    ShareContentType_Image = 1, //图片类型
    ShareContentType_Text  = 2, //文本类型
    ShareContentType_Link  = 3, //链接类型
};

#endif /* DefineConfig_h */
