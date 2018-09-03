//
//  ClassifyNameListCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyModel.h"

@interface ClassifyNameListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong)ClassifyBrandListModel *model;

@end
