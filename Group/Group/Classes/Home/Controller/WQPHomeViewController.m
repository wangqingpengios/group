//
//  WQPHomeViewController.m
//  Group
//
//  Created by home on 2017/7/25.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPHomeViewController.h"
#import "WQPCategoryView.h"
@interface WQPHomeViewController ()<UIScrollViewDelegate>
/*！ 首页分为一下三大部分   */
@property (nonatomic, strong) UIView *headView;
/*! 里面包含3个按钮  */
@property (nonatomic, strong) WQPCategoryView *categoryView;
/*! 里面包含菜单，评价，商户控制器  */
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WQPHomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.alpha = 0.0;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setupUI];
}

#pragma mark - 设置界面
- (void)setupUI {
    
    self.headView.hidden = NO;
    
    self.categoryView.hidden = NO;
    
    self.scrollView.hidden = NO;
}

#pragma mark - scrollerViewDelegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 只要这三个属性有一个为真,则表示用户正在手动拖拽scrollView
    if (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
        CGFloat offsetX = scrollView.contentOffset.x;
        
        self.categoryView.offsetX = offsetX / 3;
    }
    
}

#pragma mark - 点击title
- (void)selectedIndex:(WQPCategoryView *)categoryView {
    
    [self.scrollView setContentOffset:CGPointMake(categoryView.selectedIndex * self.scrollView.bounds.size.width, 0) animated:YES];
}

#pragma mark - getter & setter 
- (UIView *)headView {
    
    if (!_headView) {
        self.headView = [[UIView alloc]init];
        [self.view addSubview:self.headView];
        self.headView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(124);
        }];
    }
    return _headView;
}

- (WQPCategoryView *)categoryView {
    
    if (!_categoryView) {
        self.categoryView = [[WQPCategoryView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:self.categoryView];
        self.categoryView.backgroundColor = [UIColor whiteColor];
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
        [self.categoryView addTarget:self action:@selector(selectedIndex:) forControlEvents:UIControlEventValueChanged];
        self.categoryView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    return _categoryView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:self.scrollView];
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryView.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        
        UIView * contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.mas_equalTo(self.scrollView).multipliedBy(3);
            make.height.mas_equalTo(self.scrollView);
        }];
        
        
        //控制器数组
        NSArray * vcs = @[@"WQPShopFoodViewController",@"WQPCommentViewController",@"WQPShopInfoViewController"];
        NSInteger index = 0;
        for (NSString * clsName in vcs) {
            Class class = NSClassFromString(clsName);
            
            UIViewController * vc = [[class alloc]init];
            
            [self al_addChildViewController:vc intoView:contentView];
            
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(contentView);
                make.width.mas_equalTo(self.scrollView);
                make.left.equalTo(self.scrollView).offset(AL_SCREEN_WIDTH * index);
            }];
            
            index ++;
        }
        
    }
    return _scrollView;
}
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)al_addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView{
    // 添加控制器的view
    [contentView addSubview:childVc.view];
    // 添加子控制器
    [self addChildViewController:childVc];
    // 完成子控制器的添加
    [childVc didMoveToParentViewController:self];
}
@end
