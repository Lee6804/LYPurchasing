//
//  MainRecomMoreGoodsCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomMoreGoodsCell.h"

@implementation MainRecomMoreGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)setModel:(MainNewListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.mallNameLabel.text = model.mallName;
    NSMutableAttributedString *stra = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",model.declinePercent,model.infoTitle]];
    [stra addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, model.declinePercent.length)];
    self.titleLabel.attributedText = stra;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.minPriceRMB floatValue]];
    [self.countryIconImg sd_setImageWithURL:[NSURL URLWithString:model.countryIcon] placeholderImage:[UIImage imageNamed:@"photo"]];
}

@end
