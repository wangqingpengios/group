//
//  WQPFoodModel.h
//  Group
//
//  Created by home on 2017/7/31.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQPFoodModel : NSObject


/**
 *  菜品名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  菜品图片
 */
@property (nonatomic, copy) NSString *picture;
/**
 *  菜品描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  月售数量
 */
@property (nonatomic, strong) NSNumber *month_saled;
/**
 *  月售数量字符串
 */
@property (nonatomic, copy) NSString *month_saled_content;
/**
 *  价格
 */
@property (nonatomic, strong) NSNumber *min_price;
/**
 *  点赞数量
 */
@property (nonatomic, strong) NSNumber *praise_num;
/**
 *  点菜数量
 */
@property (nonatomic, assign) NSInteger orderCount;

+ (instancetype)foodModelWithDict:(NSDictionary *)dict;

@end
