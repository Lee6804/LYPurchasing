//
//  MainRecomTitleIntervalCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomTitleIntervalCell.h"

@implementation MainRecomTitleIntervalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)setModel:(MainModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
}

@end
