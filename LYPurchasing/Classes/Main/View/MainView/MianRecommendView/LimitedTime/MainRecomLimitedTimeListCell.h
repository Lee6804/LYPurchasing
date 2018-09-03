//
//  MainRecomLimitedTimeListCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomLimitedTimeListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *minPriceRMBLabel;
@property (weak, nonatomic) IBOutlet UILabel *orginalPriceRMBLabel;

@property(nonatomic,strong)MainRecomLimitedTimeGoodsListModel *model;
//
@end
