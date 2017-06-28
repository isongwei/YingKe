//
//  SW_BaseTabBarCtrl.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_BaseTabBarCtrl.h"
#import "SW_BaseNavCtrl.h"

@interface SW_BaseTabBarCtrl ()
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation SW_BaseTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _array  =[NSMutableArray array];
    [self createUI];

}

-(void)createUI{
 
    //点击颜色
        self.tabBar.tintColor = [UIColor colorWithRed:0.00f green:0.85f blue:0.79f alpha:1.00f];
    
//    self.tabBar.barTintColor = [UIColor colorWithRed:0.00f green:0.85f blue:0.79f alpha:1.00f];
    
    [self addViewControllerString:@"SW_ShouyeViewController" Title:@"首页"  imagestr:@"tab_live"];
    [self addViewControllerString:@"SW_FujinViewController" Title:@"附近" imagestr:@"tab_near"];
    [self addViewControllerString:@"SW_GuanzhuViewController" Title:@"关注"  imagestr:@"tab_following"];
    [self addViewControllerString:@"SW_MineViewController" Title:@"我"  imagestr:@"tab_me"];
    
    

    
}

-(void)addViewControllerString:(NSString *)ctrlName Title:(NSString *)title imagestr:(NSString *)imagestr{
    
    Class class = NSClassFromString(ctrlName);
    UIViewController * VC = [[class alloc]init];
    
    SW_BaseNavCtrl * nav = [[SW_BaseNavCtrl alloc]initWithRootViewController:VC];
    
    
    VC.tabBarItem.image = [[UIImage imageNamed:imagestr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:[imagestr stringByAppendingString:@"_p"]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
//    VC.tabBarItem.imageInsets = UIEdgeInsetsMake(12, 0, -12, 0);
//    VC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 40);
    
    VC.title = title;
    
    
    
    [_array addObject:nav];
    self.viewControllers = _array;
}

@end
