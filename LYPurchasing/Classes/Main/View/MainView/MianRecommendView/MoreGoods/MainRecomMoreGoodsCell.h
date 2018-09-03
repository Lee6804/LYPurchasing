//
//  MainRecomMoreGoodsCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomMoreGoodsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryIconImg;
@property (weak, nonatomic) IBOutlet UILabel *mallNameLabel;

@property(nonatomic,strong)MainNewListModel *model;

@end
