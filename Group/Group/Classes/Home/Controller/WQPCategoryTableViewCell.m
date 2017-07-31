//
//  WQPCategoryTableViewCell.m
//  Group
//
//  Created by home on 2017/7/28.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPCategoryTableViewCell.h"


@interface WQPCategoryTableViewCell ()


@end


@implementation WQPCategoryTableViewCell

/*! xib   */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}


/*! 纯代码创建走这个方法  */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    
    return self;
}

/*! 设置界面  */
- (void)setupUI {
    
    self.textLabel.textColor = [UIColor orangeColor];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.textAlignment = 1;
    self.textLabel.numberOfLines = 2;
    self.textLabel.highlightedTextColor = [UIColor blackColor];
    
//    UIView * backColorView = [[UIView alloc]init];
//    backColorView.backgroundColor = [UIColor whiteColor];
//    self.selectedBackgroundView = backColorView;
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
