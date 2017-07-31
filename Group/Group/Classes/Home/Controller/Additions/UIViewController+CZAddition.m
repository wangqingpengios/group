//
//  UIViewController+CZAddition.m
//  01-美团外卖-(掌握)
//
//  Created by 教师机 on 16/10/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "UIViewController+CZAddition.h"

@implementation UIViewController (CZAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)hm_addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView{
    // 添加控制器的view
    [contentView addSubview:childVc.view];
    // 添加子控制器
    [self addChildViewController:childVc];
    // 完成子控制器的添加
    [childVc didMoveToParentViewController:self];
}
@end
