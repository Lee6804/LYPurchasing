//
//  ClassifyListCollectionViewCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyModel.h"

@interface ClassifyListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property(nonatomic,strong)ClassifyListModel *model;

@end
