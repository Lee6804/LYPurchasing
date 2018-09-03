//
//  MainNewSearchListView.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainNewSearchListView : UIView

- (instancetype)initWithFrame:(CGRect)frame searchListArr:(NSArray *)searchListArr;

@end

@interface MainNewSearchListCollectionView : UICollectionViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)MainNewSearchBarListModel *model;

@end
