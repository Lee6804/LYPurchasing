//
//  MainHotSpecialCell.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainHotSpecialCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property(nonatomic,strong)MainHotSpecialListModel *model;

@end
