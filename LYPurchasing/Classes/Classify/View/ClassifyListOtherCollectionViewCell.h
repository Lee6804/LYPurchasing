//
//  ClassifyListOtherCollectionViewCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyModel.h"

@interface ClassifyListOtherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property(nonatomic,strong)ClassifyListModel *model;

@property(nonatomic,strong)ClassifyBrandListModel *brandModel;

@end
