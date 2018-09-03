//
//  MainRecomLimitedTimeListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomLimitedTimeListCell.h"

@implementation MainRecomLimitedTimeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainRecomLimitedTimeGoodsListModel *)model{
    
    _model = model;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.titleLabel.text = model.infoTitle;
    self.minPriceRMBLabel.text = [NSString stringWithFormat:@"¥%.0f",[model.minPriceRMB floatValue]];
    self.orginalPriceRMBLabel.text = [NSString stringWithFormat:@"¥%.0f",[model.orginalPriceRMB floatValue]];
}

@end
