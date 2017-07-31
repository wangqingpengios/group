//
//  WQPFoodTableViewCell.m
//  Group
//
//  Created by home on 2017/7/31.
//  Copyright © 2017年 qingpengwang. All rights reserved.
//

#import "WQPFoodTableViewCell.h"
#import "WQPCategoryModel.h"
#import "WQPFoodModel.h"
#import "UIImageView+WebCache.h"

@interface WQPFoodTableViewCell ()

/**
 *  名称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  价格
 */
@property (nonatomic, weak) UILabel *priceLabel;
/**
 *  点赞数
 */
@property (nonatomic, weak) UILabel *prasieLabel;
/**
 *  月售
 */
@property (nonatomic, weak) UILabel *monthSaleLabel;
/**
 *  描述
 */
@property (nonatomic, weak) UILabel *descLabel;
/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation WQPFoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 间距
    CGFloat margin = 10;
    // 图片尺寸
    CGSize iconSize = CGSizeMake(50, 50);
    // 图片视图
    UIImageView *iconView = [[UIImageView alloc] init];
    // 设置圆角
    iconView.layer.cornerRadius = 5;
    
    // view.clipsToBounds == layer.masksToBounds
    //    iconView.layer.masksToBounds = YES;
    
    // 设置图片的内容模式
    // 该属性要结合clipsToBounds使用
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.clipsToBounds = YES;
    
    [self.contentView addSubview:iconView];
    // 添加约束
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(margin);
        make.size.mas_equalTo(iconSize);
    }];
    
    // 菜品名称
    UILabel *nameLabel = [UILabel cz_labelWithText:@"天堂饭" fontSize:13 color:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    // 添加约束
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(margin);
    }];
    
    
    // 菜品描述
    UILabel *descLabel = [UILabel cz_labelWithText:@"家配送范围有限，建议分享送范围有限，建议分送范围有限，建议分送范围有限，建议分给您附近的朋友" fontSize:11 color:[UIColor cz_colorWithHex:0x7e7e7e]];
    [self.contentView addSubview:descLabel];
    // 添加约束
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(margin * 0.5);
        make.right.equalTo(self.contentView).offset(-margin);
    }];
    
    // 月售量
    UILabel *monthSaleLabel = [UILabel cz_labelWithText:@"月售 200" fontSize:11 color:[UIColor cz_colorWithHex:0x7e7e7e]];
    [self.contentView addSubview:monthSaleLabel];
    // 添加约束
    [monthSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLabel.mas_bottom).offset(margin * 0.75);
        make.left.equalTo(nameLabel);
    }];
    
    // 点赞图片
    UIImageView *praiseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_review_praise"]];
    [self.contentView addSubview:praiseView];
    // 添加约束:praiseView
    [praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(monthSaleLabel.mas_right).offset(margin);
        make.centerY.equalTo(monthSaleLabel);
    }];
    
    // 点赞数量
    UILabel *praiseLabl = [UILabel cz_labelWithText:@"300" fontSize:11 color:[UIColor cz_colorWithHex:0x7e7e7e]];
    [self.contentView addSubview:praiseLabl];
    // 添加约束
    [praiseLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(praiseView.mas_right).offset(margin * 0.5);
        make.centerY.equalTo(praiseView).offset(1);
    }];
    // 价格
    UILabel *priceLabl = [UILabel cz_labelWithText:@"¥ 300" fontSize:14 color:[UIColor cz_colorWithHex:0xfa2a09]];
    priceLabl.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:priceLabl];
    // 添加约束
    [priceLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(praiseLabl.mas_bottom).offset(margin * 0.6);
    }];
    
    
    // 记录属性
    self.nameLabel  = nameLabel;
    self.iconView = iconView;
    self.priceLabel = priceLabl;
    self.prasieLabel = praiseLabl;
    self.descLabel = descLabel;
    self.monthSaleLabel = monthSaleLabel;
    
}

- (void)setFoodModel:(WQPFoodModel *)foodModel {
    _foodModel = foodModel;
    self.nameLabel.text = foodModel.name;
    self.descLabel.text = foodModel.desc;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[foodModel.min_price floatValue]];
    self.prasieLabel.text = foodModel.praise_num.description;
    self.monthSaleLabel.text = [NSString stringWithFormat:@"月售 %@",foodModel.month_saled];
    // 下载图片
    // stringByDeletingPathExtension:删除路径的后缀
    //    SDWebImageRetryFailed = 1 << 0, 当下载失败时尝试重新下载
    //    SDWebImageLowPriority = 1 << 1, 低优先级,当滚动表格时暂停下载
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]] placeholderImage:[UIImage imageNamed:@"aaa"] options:SDWebImageRetryFailed | SDWebImageLowPriority];

}

@end
