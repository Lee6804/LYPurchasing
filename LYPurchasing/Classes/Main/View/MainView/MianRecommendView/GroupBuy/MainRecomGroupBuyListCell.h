//
//  MainRecomGroupBuyListCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomGroupBuyListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *singleBuyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupBuyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineDescLabel;

@property(nonatomic,strong)MainModel *model;

@end
