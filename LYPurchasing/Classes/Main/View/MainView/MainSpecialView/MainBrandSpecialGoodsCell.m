//
//  MainBrandSpecialGoodsCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainBrandSpecialGoodsCell.h"

@implementation MainBrandSpecialGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainBrandSpecialGoodsListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.strMainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self.countryImg sd_setImageWithURL:[NSURL URLWithString:model.countrySmallIcon] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.mallLabel.text = model.mall[@"strMallName"];
    NSMutableAttributedString *stra = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",model.declinePercent,model.strInfoTitle]];
    [stra addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, model.declinePercent.length)];
    self.titleLabel.attributedText = stra;
    self.princeLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.decMinPriceRMB floatValue]];
}

-(void)setRecomModel:(MainRecomHotSpecialGoodsListModel *)recomModel{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:recomModel.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self.countryImg sd_setImageWithURL:[NSURL URLWithString:recomModel.countryIcon] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.mallLabel.text = recomModel.mallName;
    NSMutableAttributedString *stra = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",recomModel.declinePercent,recomModel.infoTitle]];
    [stra addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, recomModel.declinePercent.length)];
    self.titleLabel.attributedText = stra;
    self.princeLabel.text = [NSString stringWithFormat:@"¥%.2f",[recomModel.minPriceRMB floatValue]];
}

@end
