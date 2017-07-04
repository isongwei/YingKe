//
//  mmtMacros.h
//  maimaiti2.0
//
//  Created by zhangsongwei on 16/5/20.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#ifndef mmtMacros_h
#define mmtMacros_h



//==================== Server ===================



//加密
//参数key
#define DESparameterKEY @""
//接口key
#define DESAPIKEY @""


//极光推送

#define JPUSHAppKey @""

//友盟统计
//友盟分享
#define UmengAppkey @""

//用户存储信息
#define AppUser [AppDefaultUtil sharedInstance]




//接口服务器地址
#define NetClient [NetWorkClient sharedClient]



//-------------------获取设备-------------------------



//获取屏幕 宽度、高度
#define SCREENBOUNDS    [UIScreen mainScreen].bounds
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)


#define Timeout 90 //短信验证超时
#define TimeoutInterval 120.0 // 请求超时时间

//颜色


#define RGBColor(...)  [UIColor colorWithHexString:__VA_ARGS__]


// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)






//weak

#define WS(weakSelf);  __weak __typeof(&*self)weakSelf = self;


//提示语句
//#define HUDError(...) [MBProgressHUD showError:__VA_ARGS__];
//#define HUDSuccess(...) [MBProgressHUD showSuccess:__VA_ARGS__];
//#define HUDNetError  [MBProgressHUD netError];

//#define HUDError(...)  [[SWProgressHUD defaultView] showTitle:__VA_ARGS__ autoCloseTime:1.0];
//#define HUDSuccess(...) [[SWProgressHUD defaultView] showTitle:__VA_ARGS__ autoCloseTime:1.0];



#define Wait_Interval 1.0

#define HUDLoding  [[SWProgressHUD defaultView] showLoading];
#define HUDMaskView  [[SWProgressHUD defaultView] showMaskView];
#define HUDLodingHide  [[SWProgressHUD defaultView] hide];  
#define HUDShowMessage(...) [[SWProgressHUD defaultView] showTitle:__VA_ARGS__ autoCloseTime:Wait_Interval];
#define HUDNetError  [[SWProgressHUD defaultView] showTitle:@"网络连接失败,请重试!" autoCloseTime:Wait_Interval];



//打印日志

#ifdef DEBUG
//#define DLog(...) NSLog(__VA_ARGS__)
//#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DLog(format, ...) printf("\n时间:[%s] 方法:%s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(format, ...)
#endif



// 打印方法名字
#define PRINT_METHOD_NAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SystemVersion [[UIDevice currentDevice] systemVersion]



//判断iPhone
#define IS_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_iPhone5  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_iPhone6  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)



//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]



#endif /* mmtMacros_h */
