//
//  RankModel.h
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@end

@interface RankGoodsListModel : NSObject

@property(nonatomic,strong)NSString *InfoTitle;
@property(nonatomic,strong)NSString *MainImage;
@property(nonatomic,strong)NSString *MinPriceRMB;
@property(nonatomic,strong)NSString *declinePercent;
@property(nonatomic,strong)NSString *HotDegree;

@end
