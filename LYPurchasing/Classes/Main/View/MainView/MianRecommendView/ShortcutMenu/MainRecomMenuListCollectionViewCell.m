//
//  MainRecomMenuListCollectionViewCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomMenuListCollectionViewCell.h"

@implementation MainRecomMenuListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainShortcutMenuListModel *)model{
    _model = model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.titleLabel.text = model.name;
}

@end
