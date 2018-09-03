//
//  ClassifyNameListCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifyNameListCell.h"

@implementation ClassifyNameListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ClassifyBrandListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.strBrandLogo] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",model.strBrandEngName,model.strBrandName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
