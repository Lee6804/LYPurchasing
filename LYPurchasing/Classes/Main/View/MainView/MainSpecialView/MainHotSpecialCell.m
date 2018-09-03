//
//  MainHotSpecialCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainHotSpecialCell.h"

@implementation MainHotSpecialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = TABBACKGCOLOR;
}

-(void)setModel:(MainHotSpecialListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.strSpecialImage] placeholderImage:[UIImage imageNamed:@"photo"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
