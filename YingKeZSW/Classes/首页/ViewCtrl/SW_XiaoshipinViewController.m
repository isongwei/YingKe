//
//  SW_XiaoshipinViewController.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_XiaoshipinViewController.h"

@interface SW_XiaoshipinViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SW_XiaoshipinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:<#(nonnull NSHTTPCookie *)#>]
    
    
//    //判断是否沙盒中是否有这个值
//    if ([[[[NSUserDefaults standardUserDefaults]dictionaryRepresentation]allKeys]containsObject:@"cookie"]) {
//        //获取cookies：程序起来之后，uiwebview加载url之前获取保存好的cookies，并设置cookies，
//        NSArray *cookies =[[NSUserDefaults standardUserDefaults]  objectForKey:@"cookie"];
//        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//        [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
//        [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
//        [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
//        [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
//        NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
//    }
    
    
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"__bsi" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"12411966622401254525_00_6_R_R_7_0303_c02f_Y" forKey:NSHTTPCookieValue];
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
    
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];

    
    
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *cookie;
    NSDictionary * dic;
    for (id c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]]){
            cookie=(NSHTTPCookie *)c;
            
            dic = @{cookie.name:cookie.value};
//            NSLog(@"NSHTTPCookie===%@: %@", cookie.name, cookie.value);
        }
    }
        
        NSLog(@"%@", dic);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


// 保存数据到本地
- (BOOL) SetLocalData:(NSString *)dataFile dataObject:(NSMutableDictionary *)dataObject{
    // 设置路径,并保存
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *saveFile = [savePath stringByAppendingPathComponent:dataFile];
    [NSKeyedArchiver archiveRootObject:dataObject toFile:saveFile];
    return YES;
}

// 读取本地保存的数据
- (NSMutableDictionary *) GetLocalData:(NSString *)dataFile {
    // 按文件名来读取数据
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *saveFile = [savePath stringByAppendingPathComponent:dataFile];return [NSKeyedUnarchiver unarchiveObjectWithFile: saveFile];
}

@end
