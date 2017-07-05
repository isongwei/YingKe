
//
//  SW_HotViewController.m
//  YingKeZSW
//
//  Created by iSongWei on 2017/6/29.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SW_HotViewController.h"
#import "SW_HotViewCell.h"


@interface SW_HotViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray * bannerArray;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,weak) IBOutlet UITableView * tableView;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation SW_HotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initView];

    [self requestData];
    
    

}


#pragma mark - ===============init===============

-(void)initData{
    
    _bannerArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
}
-(void)initView{
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"SW_HotViewCell" bundle:nil] forCellReuseIdentifier:@"SW_HotViewCell"];
    
    // 网络加载图片的轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.35)) delegate:self placeholderImage:nil];
    [self.view addSubview:_cycleScrollView];
    
                                          
                                          
                                          
    
}
#pragma mark - ===============SDCycleScrollViewDelegate===============
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}




#pragma mark - ===============requestData===============
-(void)requestData{
    [MBManager showLoading];
    [NetClient  GET:YK_URL_HOT1 parameter:nil success:^(MainModel *dataModel) {
        
        //banner
        NSMutableArray * imageArray = [ NSMutableArray array];
        for (NSDictionary  *dic  in dataModel.ticker) {
            [_bannerArray addObject:dic];
            [imageArray addObject:dic[@"image"]];
        }
        _cycleScrollView.imageURLStringsGroup = imageArray;
        
        
        [self requestData1];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)requestData1{
    
    [NetClient  GET:YK_URL_HOT2 parameter:nil success:^(MainModel *dataModel) {
        
        //lives
        for (NSDictionary  *dic  in dataModel.lives) {
            [_dataArray addObject:dic];
        }
        NSLog(@"%@", [NSThread currentThread]);
        
        [_tableView reloadData];
        
        [MBManager hideAlert];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - ===============UITableViewDelegate===============


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count) {
        NSDictionary * dic =  _dataArray[indexPath.row];
        static NSString * acell = @"SW_HotViewCell";
        SW_HotViewCell * cell = [tableView dequeueReusableCellWithIdentifier:acell];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"creator"][@"portrait"]] placeholderImage:nil];
        
//        [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:dic[@"creator"][@"portrait"]]];
//        [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:dic[@"creator"][@"portrait"]]];
        
        
        return cell;
    }else{
        return nil;
    }

    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _cycleScrollView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return _cycleScrollView.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[SW_BaseViewCtrl alloc]init] animated:YES];
}




@end
