
//
//  MainRecomNewOrderListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomNewOrderListCell.h"

@implementation MainRecomNewOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.topLine.layer.borderColor = BORDERCOLOR.CGColor;
    self.topLine.layer.borderWidth = 0.5;
    
    self.bottomLine.layer.borderColor = BORDERCOLOR.CGColor;
    self.bottomLine.layer.borderWidth = 0.5;
}


-(void)setModel:(MainRecomNewOrderListModel *)model{
    _model = model;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self.countryImg sd_setImageWithURL:[NSURL URLWithString:model.countryIcon] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.mallLabel.text = model.mallName;
    self.titleLabel.text = model.infoTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.minPriceRMB floatValue]];
}

@end
