//
//  SW_ShouyeViewController.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_ShouyeViewController.h"

@interface SW_ShouyeViewController ()

@end

@implementation SW_ShouyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * strDic = @{@"Faxian":@"发现",@"Hot":@"热门",@"Xiaoshipin":@"小视频",@"Youxi":@"游戏",};
    
    for (NSString  * str in [strDic allKeys]) {
        Class class = NSClassFromString([NSString stringWithFormat:@"SW_%@ViewController",str]);
        UIViewController * vc = [class new];
        vc.title = strDic[str];
        [self.childVCArr addObject: vc];
    }
    self.titleViewFrame = CGRectMake(0, 0, 250, 44);
    [self updateUI];
    
    self.navigationItem.titleView = self.titleView;
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    UIView * v = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 300, 44))];
    v.backgroundColor = [UIColor redColor];
    
    
}



@end
