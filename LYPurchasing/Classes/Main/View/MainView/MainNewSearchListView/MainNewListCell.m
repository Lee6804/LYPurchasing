//
//  MainNewListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainNewListCell.h"

@implementation MainNewListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainNewListModel *)model{
    _model = model;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.mallNameLabel.text = model.mallName;
    self.updateTimeLabel.text = [model.updateTime substringFromIndex:14];
    NSMutableAttributedString *stra = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",model.declinePercent,model.infoTitle]];
    [stra addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, model.declinePercent.length)];
    self.titleLabel.attributedText = stra;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.minPriceRMB floatValue]];
    self.goodCountLabel.text = model.isGood;
    self.reviewCountLabel.text = model.infoReview;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
