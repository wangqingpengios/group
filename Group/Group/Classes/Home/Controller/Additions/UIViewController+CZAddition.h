//
//  UIViewController+CZAddition.h
//  01-美团外卖-(掌握)
//
//  Created by 教师机 on 16/10/12.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CZAddition)
/**
 *  添加子控制器
 *
 *  @param childVc     要添加的子控制器
 *  @param contentView 子控制器view的父控件
 */
- (void)hm_addChildViewController:(UIViewController *)childVc intoView:(UIView *)contentView;
@end
