//
//  AppDelegate.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "AppDelegate.h"
#import "SW_BaseTabBarCtrl.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UIViewController alloc]init];
    [_window makeKeyAndVisible];
    
    [self setupConfig];
    
    
    SW_BaseTabBarCtrl * tab = [[SW_BaseTabBarCtrl alloc]init];
    _window.rootViewController = tab;
    
    
    
    
    return YES;
}

#pragma mark - ===============setupConfig===============
-(void)setupConfig{
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[NSObject baseURLStrIsProduction]? kColorNavBG: kColorBrandGreen] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:[UIColor greenColor]];//返回按钮的箭头颜色
    [navigationBarAppearance setBarTintColor:[UIColor colorWithRed:0.00f green:0.85f blue:0.79f alpha:1.00f]];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
//    [[UITextField appearance] setTintColor:kColorBrandGreen];//设置UITextField的光标颜色
//    [[UITextView appearance] setTintColor:kColorBrandGreen];//设置UITextView的光标颜色
//    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

#pragma mark - ===============周期===============

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
