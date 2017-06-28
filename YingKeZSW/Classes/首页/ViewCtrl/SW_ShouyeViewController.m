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
    
    NSArray * strArr = @[@"Faxian",@"Remen",@"Xiaoshipin",@"Youxi",];
    
    for (NSString  * str in strArr) {
        Class class = NSClassFromString([NSString stringWithFormat:@"SW_%@ViewController",str]);
        [self.childVCArr addObject: [class new]];
    }
    
    [self updateUI];
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    UIView * v = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, 300, 44))];
    v.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = v;
    
}



@end
