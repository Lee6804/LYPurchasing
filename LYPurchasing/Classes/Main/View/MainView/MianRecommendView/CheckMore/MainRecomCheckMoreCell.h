//
//  MainRecomCheckMoreCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainRecomCheckMoreCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property(nonatomic,strong)MainModel *model;

@end
