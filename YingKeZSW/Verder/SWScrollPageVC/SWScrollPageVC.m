//
//  SWScrollPageVC.m
//  仿网易菜单滚动
//
//  Created by iSongWei on 2017/2/22.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "SWScrollPageVC.h"

#define buttonTag 19920115


#define origin_Y 20
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define btnW 65

#define btnColor [UIColor colorWithHexString:@"333333"]
#define btnSColor [UIColor colorWithHexString:@"000000"]
#define btnScale 1.3
#define btnFontSize 14
#define hasLine 0


@interface SWScrollPageVC ()<UIScrollViewDelegate>
// 标题scrollView
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic,strong)  NSMutableArray<UIButton *> *buttonArr;
@property (nonatomic,strong) UIButton * selButton;
// 内容scrollView
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) UIView  * lineView;

@property (nonatomic, assign) BOOL isSuc;//加载过了

@end



@implementation SWScrollPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor =[UIColor clearColor];
    //
    _childVCArr = [NSMutableArray array];
    _buttonArr = [NSMutableArray array];
    
    // 1.设置标题scrollView
    [self titleScrollView];
    [self contentScrollView];
    
    [self.view addSubview:self.titleScrollView];
    
    // 2.设置内容scrollView
    [self.view addSubview:self.contentScrollView];
    
    
}
-(UIScrollView *)titleScrollView{
    
    if (!_titleScrollView) {
        // 验证是否有navigationController或navigationBar是否隐藏
        UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, origin_Y, SCREEN_W, 44)];
        titleScrollView.delegate = self;
        titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView = titleScrollView;

    }
    return _titleScrollView;

}

-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  origin_Y+self.titleScrollView.frame.size.height, SCREEN_W, SCREEN_H-64-49)];
        contentScrollView.delegate = self;
        contentScrollView.pagingEnabled = YES;
        contentScrollView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _contentScrollView = contentScrollView;
    }
    return _contentScrollView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self updateUI];
    
}


#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    for (UIViewController *childVC in self.childVCArr) {
        [self addChildViewController:childVC];
    }
    
    // 设置内容scrollView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(self.childVCArr.count * SCREEN_W,  self.contentScrollView.frame.size.height);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 设置所有标题
- (void)setupAllTitleButton
{
    
    NSInteger l_w = 0;
    NSInteger btn_w = 0;
    NSInteger count = self.childVCArr.count;
    //需要根据长度定下
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    //lineView
    
    if (hasLine) {
        _lineView = [[UIView alloc]initWithFrame:(CGRectMake(5, btnH-5, btnW-10, 3))];
        _lineView.backgroundColor = [UIColor greenColor];
        [_titleScrollView addSubview:_lineView];
    }

    
    for (NSInteger i = 0; i < count; i++) {
        btnX = i * btnW;

        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.backgroundColor = [UIColor clearColor];
        titleButton.tag = i + buttonTag;
        UIViewController *vc = self.childVCArr[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        
        #pragma mark - ==============================
        btn_w = vc.title.length * btnFontSize + 35;
        
        titleButton.frame = CGRectMake(l_w, 0, btn_w, btnH);
  
        l_w += btn_w;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:btnFontSize];
        [titleButton setTitleColor:btnColor forState:UIControlStateNormal];
        
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArr addObject:titleButton];
        [self.titleScrollView addSubview:titleButton];
        if (i == 0) {
            // 默认点击第一个标题
            [self titleClick:titleButton];
        }

    }
    
    // 设置标题scrollView的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(l_w, btnH);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    

 
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSInteger l_w = self.titleScrollView.contentSize.width;
    if (l_w < SCREEN_W) {
        [self.titleScrollView setContentOffset:CGPointMake(-(SCREEN_W - l_w)*0.5, 0) animated:NO];
    }
}

#pragma mark -  按钮点击事件
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag - buttonTag;
    // 按钮选中状态
    [self selButton:button];
    
    // 把对应子控制器view添加上去
    [self setupChildVCView:i];
    
    // 内容滚动到对应的位置
    CGFloat offsetX = i * SCREEN_W;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
}


#pragma mark - 添加一个子控制器的View
- (void)setupChildVCView:(NSInteger)i
{
    UIViewController *vc = self.childVCArr[i];
    if (vc.view.superview) {
        return;
    }
    
    CGFloat x = i * SCREEN_W;
    vc.view.frame = CGRectMake(x, 0, SCREEN_W, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}


#pragma mark - 按钮选中状态
- (void)selButton:(UIButton *)button
{
    // 恢复上一个标题的样式
    if (_selButton) {
        _selButton.transform = CGAffineTransformIdentity;
        [_selButton setTitleColor:btnColor forState:UIControlStateNormal];
    }

    
    // 设置标题选中样式
    [button setTitleColor:btnSColor forState:UIControlStateNormal];
    button.transform = CGAffineTransformMakeScale(btnScale, btnScale);
    
    //记录最近被点击的按钮
    _selButton = button;
    
    
    //调节button位置
    [self setupTitleView:button];
    

}
#pragma mark - 调节button位置

-(void)setupTitleView:(UIButton * )button{
    
    if (_titleScrollView.contentSize.width < SCREEN_W) {
        [self.titleScrollView setContentOffset:CGPointMake(-(SCREEN_W - _titleScrollView.contentSize.width)*0.5, 0) animated:NO];
        return;
    }
    
    CGFloat offsetX = button.center.x - SCREEN_W * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = _titleScrollView.contentSize.width-SCREEN_W;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (scrollView == _contentScrollView) {
        NSInteger i = scrollView.contentOffset.x / SCREEN_W;
        UIButton *titleButton = self.buttonArr[i];
        [self titleClick:titleButton];
    }
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == _contentScrollView) {
        CGRect frame = _lineView.frame;
        frame.origin.x = _contentScrollView.contentOffset.x/SCREEN_W*btnW+3;
        _lineView.frame = frame;
        
        
        if (scrollView == _contentScrollView && scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= (_buttonArr.count-1) * SCREEN_W) {
            NSInteger leftI = scrollView.contentOffset.x / SCREEN_W;
            NSInteger rightI = 1 + leftI;
            
            UIButton *leftBtn = self.buttonArr[leftI];
            NSInteger count = self.buttonArr.count;
            
            UIButton *rightBtn;
            if (rightI < count) {
                rightBtn = self.buttonArr[rightI];
            }
            
            // 0~1 => 1~1.3
            CGFloat scaleR = scrollView.contentOffset.x / SCREEN_W;
            scaleR -= leftI;
            
            
            CGFloat scaleL = 1 - scaleR;
            leftBtn.transform = CGAffineTransformMakeScale(scaleL * (btnScale -1) + 1, scaleL * (btnScale -1) + 1);
            rightBtn.transform = CGAffineTransformMakeScale(scaleR * (btnScale -1) + 1, scaleR * (btnScale -1) + 1);
            
            //        UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
            //        UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
            //        [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
            //        [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
        }
    }
    
    
    
 
}
#pragma mark - ===============更新UI===============
-(void)updateUI{
    
    
    if (self.childVCArr.count == 0) {
        return;
    }
    
    if (!_isSuc) {
        // 4.设置所有标题
        [self setupAllTitleButton];
        
        // 3.添加所有子控制器
        [self setupAllChildViewController];
        _isSuc = YES;
    }else{
        if (_titleScrollView.contentSize.width < SCREEN_W) {
            [self.titleScrollView setContentOffset:CGPointMake(-(SCREEN_W - _titleScrollView.contentSize.width)*0.5, 0) animated:NO];
        }
    }
    
}




@end
