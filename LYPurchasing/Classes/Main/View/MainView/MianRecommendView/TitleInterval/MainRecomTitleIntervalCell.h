//
//  MainRecomTitleIntervalCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomTitleIntervalCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)MainModel *model;

@end