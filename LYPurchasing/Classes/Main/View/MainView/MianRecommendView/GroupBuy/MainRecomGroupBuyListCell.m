//
//  MainRecomGroupBuyListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomGroupBuyListCell.h"

@implementation MainRecomGroupBuyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainModel *)model{
    
    MainRecomGroupBuyListModel *groupBuyModel = [MainRecomGroupBuyListModel mj_objectWithKeyValues:model.item];
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:groupBuyModel.mainImage] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.titleLabel.text = groupBuyModel.infoTitle;
    self.singleBuyPriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[groupBuyModel.singleBuyPrice floatValue]];
    self.groupBuyPriceLabel.text = [NSString stringWithFormat:@"¥%.2f",[groupBuyModel.groupBuyPrice floatValue]];
    self.deadlineDescLabel.text = groupBuyModel.deadlineDesc;
}

@end
