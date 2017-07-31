//
//  WQPCategoryView.m
//  Group
//
//  Created by home on 2017/7/25.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPCategoryView.h"




@interface WQPCategoryView ()

/*! 按钮数组  */
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttons;

/*! 记录选中的按钮  */
@property (nonatomic, strong) UIButton *selectedBtn;

/*! lineView  */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation WQPCategoryView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)setupUI {
    
    NSArray * array = @[@"菜单",@"点评",@"商户"];
    
    NSInteger index = 0;
    
    CGFloat btnWidth = 80;
    
    
    switch (array.count) {
        case 1:
            btnWidth = AL_SCREEN_WIDTH;
            break;
        case 2:
            btnWidth = AL_SCREEN_WIDTH / 2;
            break;
        case 3:
            btnWidth = AL_SCREEN_WIDTH / 3;
            break;
        case 4:
            btnWidth = AL_SCREEN_WIDTH / 4;
            break;
    }
    
    self.buttons = [NSMutableArray array];

    for (int i = 0; i < array.count; ++i) {
        
        UIButton * button = [self al_textButton:array[i] fontSize:15 normalColor:[UIColor blackColor] selectedColor:[UIColor redColor]];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = index++;
        
        [self addSubview:button];
        
        [self.buttons addObject:button];
        

        button.frame = CGRectMake(btnWidth * i, 0, btnWidth, 40);
        
    }
    
    UIView * lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor orangeColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttons[0].mas_bottom);
        make.centerX.equalTo(self.buttons[0]);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(4);
    }];
    self.lineView = lineView;
    
    self.selectedBtn = self.buttons[0];
    
    self.selectedBtn.selected = YES;
    
    
}


- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = offsetX;
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.buttons[0]).offset(offsetX);
    }];
    self.selectedIndex = offsetX / self.buttons[0].bounds.size.width;
    self.selectedBtn.selected = NO;
    self.selectedBtn = self.buttons[self.selectedIndex];
    self.selectedBtn.selected = YES;
}


#pragma mark - 按钮点击事件
- (void)click:(UIButton *)btn {
    
    if (btn == self.selectedBtn) return;
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn ;
    self.selectedBtn.selected = YES;
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.buttons[0]).offset(btn.bounds.size.width * btn.tag);
    }];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    self.selectedIndex = btn.tag;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


/*! return button  */
- (UIButton *)al_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    
    [button setTitleColor:selectedColor forState:UIControlStateSelected];

    [button sizeToFit];
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return button;
    
}


@end
