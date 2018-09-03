//
//  MainBrandSpecialGoodsCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainBrandSpecialGoodsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *countryImg;
@property (weak, nonatomic) IBOutlet UILabel *mallLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *princeLabel;

@property(nonatomic,strong)MainBrandSpecialGoodsListModel *model;
@property(nonatomic,strong)MainRecomHotSpecialGoodsListModel *recomModel;

@end
