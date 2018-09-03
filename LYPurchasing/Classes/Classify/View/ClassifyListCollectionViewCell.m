//
//  ClassifyListCollectionViewCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifyListCollectionViewCell.h"

@implementation ClassifyListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)setModel:(ClassifyListModel *)model{
    
    self.nameLabel.text = model.strTagName;
    self.desLabel.text = model.strTagDes;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.strTagImage] placeholderImage:[UIImage imageNamed:@"photo"]];
}



@end
