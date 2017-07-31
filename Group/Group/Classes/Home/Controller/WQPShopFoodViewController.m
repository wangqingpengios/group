//
//  WQPShopFoodViewController.m
//  Group
//
//  Created by home on 2017/7/26.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPShopFoodViewController.h"
#import "WQPCategoryTableViewCell.h"
#import "WQPCategoryModel.h"
#import "WQPFoodModel.h"
#import "WQPFoodTableViewCell.h"

static NSString *CategoryCell = @"CategoryCell";

@interface WQPShopFoodViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *categoryTableView;

@property (nonatomic, strong) UITableView *foodTableView;

@property (nonatomic, strong) NSArray <WQPCategoryModel *>*titleArray;

/**
 *  标记是否点击的是分类表格
 */
@property (nonatomic, assign) BOOL isClickCategoryTv;

@end

@implementation WQPShopFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


#pragma mark - 设置界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.categoryTableView.hidden = NO;
    
    self.foodTableView.hidden = NO;
    
    [self loadData];
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

#pragma mark - 加载数据
- (void)loadData {
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    //反序列化
    NSDictionary * foodData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];

    NSArray * arr = foodData[@"data"][@"food_spu_tags"];
    
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (NSDictionary * dict in arr) {
        WQPCategoryModel * model = [WQPCategoryModel wqpCategoryModelWithDict:dict];
        [mArray addObject:model];
    }
    self.titleArray = mArray.copy;
    
}
#pragma mark - UIScorllView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断滚动的是否是菜品表格
    if(scrollView == self.categoryTableView) return;
    // 只要这三个属性有一个为真,则表示用户正在手动拖拽scrollView
    if (!_isClickCategoryTv) {
        //        NSLog(@"%s", __FUNCTION__);
        // 获得当前显示的所有indexPath行
        NSArray *indexPaths = [self.foodTableView indexPathsForVisibleRows];
        // 获得当前显示的第一行
        NSIndexPath *indexPath = indexPaths.firstObject;
        // 选中分类表格的指定的行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

/**
 *  滚动动画结束后调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __FUNCTION__);
    _isClickCategoryTv = NO;
}

#pragma mark - DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView == self.categoryTableView ? 1:self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.titleArray.count;
    }
    else {
        
        WQPCategoryModel * model = self.titleArray[section];
        
        return model.spus.count;
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCell];
    
    if (tableView == self.categoryTableView) {
        WQPCategoryModel * model = self.titleArray[indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    else {
        WQPCategoryModel * model = self.titleArray[indexPath.section];

        WQPFoodModel * data = model.spus[indexPath.row];
        WQPFoodTableViewCell * foodCell = (WQPFoodTableViewCell *)cell;
        foodCell.foodModel = data;
    }
  
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        _isClickCategoryTv = YES;
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        // 滚动菜品表格到指定的组
        [self.foodTableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
    
    
        NSLog(@"2");
    }
}




#pragma mark - getter & setter
- (UITableView *)categoryTableView {
    
    if (!_categoryTableView) {
        self.categoryTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:self.categoryTableView];
        self.categoryTableView.dataSource = self;
        self.categoryTableView.delegate = self;
        [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.view);
            make.width.mas_equalTo(86);
        }];
        [self.categoryTableView registerClass:[WQPCategoryTableViewCell class] forCellReuseIdentifier:CategoryCell];
    }
    return _categoryTableView;
}

- (UITableView *)foodTableView {
    
    if (!_foodTableView) {
        self.foodTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:self.foodTableView];
        self.foodTableView.dataSource = self;
        self.foodTableView.delegate = self;
        [self.foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.view);
            make.left.equalTo(self.categoryTableView.mas_right);
        }];
        [self.foodTableView registerClass:[WQPFoodTableViewCell class] forCellReuseIdentifier:CategoryCell];
        self.foodTableView.rowHeight = 130;
        self.foodTableView.tableFooterView = [UIView new];
    }
    return _foodTableView;
}


@end
