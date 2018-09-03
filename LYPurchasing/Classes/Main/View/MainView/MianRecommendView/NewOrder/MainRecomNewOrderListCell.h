//
//  MainRecomNewOrderListCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomNewOrderListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIImageView *countryImg;
@property (weak, nonatomic) IBOutlet UILabel *mallLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property(nonatomic,strong)MainRecomNewOrderListModel *model;

@end
