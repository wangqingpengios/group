//
//  WQPCategoryModel.h
//  Group
//
//  Created by home on 2017/7/31.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WQPFoodModel;

@interface WQPCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray <WQPFoodModel *>*spus;

+ (instancetype)wqpCategoryModelWithDict:(NSDictionary *)dict;

@end
