//
//  ClassifyListOtherCollectionViewCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifyListOtherCollectionViewCell.h"

@implementation ClassifyListOtherCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ClassifyListModel *)model{
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.strTagImage] placeholderImage:[UIImage imageNamed:@"photo"]];
}

-(void)setBrandModel:(ClassifyBrandListModel *)brandModel{
    [self.img sd_setImageWithURL:[NSURL URLWithString:brandModel.strBrandLogo] placeholderImage:[UIImage imageNamed:@"photo"]];
}

@end
