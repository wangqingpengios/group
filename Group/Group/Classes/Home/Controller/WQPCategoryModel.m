//
//  WQPCategoryModel.m
//  Group
//
//  Created by home on 2017/7/31.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPCategoryModel.h"
#import "WQPFoodModel.h"

@implementation WQPCategoryModel

+ (instancetype)wqpCategoryModelWithDict:(NSDictionary *)dict {
    WQPCategoryModel * model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"spus"]) {
        
        NSArray * spus = (NSArray *)value;
        
        NSMutableArray * mArray = [NSMutableArray array];
        
        for (NSDictionary * dict in spus) {
            WQPFoodModel * model = [WQPFoodModel foodModelWithDict:dict];
            [mArray addObject:model];
        }
        self.spus = mArray.copy;
        return;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
