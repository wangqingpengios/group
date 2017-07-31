//
//  WQPFoodModel.m
//  Group
//
//  Created by home on 2017/7/31.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPFoodModel.h"

@implementation WQPFoodModel

+ (instancetype)foodModelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        //        NSLog(@"%@--%@",value,key);
        //        self.desc = value;
        [super setValue:value forKey:@"desc"];
        return;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
