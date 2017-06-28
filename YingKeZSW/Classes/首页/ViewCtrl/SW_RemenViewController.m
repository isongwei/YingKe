
//
//  SW_RemenViewController.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/28.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_RemenViewController.h"

@interface SW_RemenViewController ()<UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView * tableView;

@end

@implementation SW_RemenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [_tableView registerNib:[UINib nibWithNibName:@"MMTInfoCenterCell" bundle:nil] forCellReuseIdentifier:@"MMTInfoCenterCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
        
    
    
}



#pragma mark - ===============UITableViewDelegate===============


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    static NSString * acell = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:acell];
    return cell;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[SW_BaseViewCtrl alloc]init] animated:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [scrollView animationWithNavigationController:self.navigationController TabBarController:self.tabBarController];
    
}


@end
