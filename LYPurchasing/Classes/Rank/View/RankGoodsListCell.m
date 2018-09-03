//
//  RankGoodsListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "RankGoodsListCell.h"

@implementation RankGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RankGoodsListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.MainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    NSMutableAttributedString *stra = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",model.declinePercent,model.InfoTitle]];
    [stra addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, model.declinePercent.length)];
    self.titleLabel.attributedText = stra;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.MinPriceRMB floatValue]];
    self.hotLabel.text = [NSString stringWithFormat:@"热度:%@%%",model.HotDegree];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
