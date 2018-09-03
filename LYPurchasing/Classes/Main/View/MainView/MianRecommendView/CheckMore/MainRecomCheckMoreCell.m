//
//  MainRecomCheckMoreCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomCheckMoreCell.h"

@implementation MainRecomCheckMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.bgImageUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
}

@end
