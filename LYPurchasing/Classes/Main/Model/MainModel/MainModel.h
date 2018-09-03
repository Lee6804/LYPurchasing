//
//  MainModel.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property(nonatomic,assign)NSInteger viewCode;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray *itemList;
@property(nonatomic,strong)NSDictionary *item;

@property(nonatomic,strong)NSString *bgImageUrl;
@property(nonatomic,strong)NSString *linkUrl;

@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)NSString *tagImageUrl;

@end

@interface MainShortcutMenuListModel : NSObject

@property(nonatomic,strong)NSString *param;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *name;

@end

@interface MainRecomNewOrderListModel : NSObject

@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *minPriceRMB;
@property(nonatomic,strong)NSString *mainImage;
@property(nonatomic,strong)NSString *countryIcon;
@property(nonatomic,strong)NSString *mallName;

@end

@interface MainRecomLimitedTimeGoodsListModel : NSObject

@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *minPriceRMB;
@property(nonatomic,strong)NSString *orginalPriceRMB;
@property(nonatomic,strong)NSString *mainImage;

@end

@interface MainRecomGroupBuyListModel : NSObject

@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *deadlineDesc;
@property(nonatomic,strong)NSString *singleBuyPrice;
@property(nonatomic,strong)NSString *groupBuyPrice;
@property(nonatomic,strong)NSString *mainImage;

@end

@interface MainRecomHotSpecialGoodsListModel : NSObject

@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *minPriceRMB;
@property(nonatomic,strong)NSString *mainImage;
@property(nonatomic,strong)NSString *countryIcon;
@property(nonatomic,strong)NSString *mallName;
@property(nonatomic,strong)NSString *declinePercent;

@end


#pragma mark - 首页最新顶部searchBar Model
@interface MainNewSearchBarListModel : NSObject

@property(nonatomic,strong)NSString *searchBarListId;
@property(nonatomic,strong)NSString *searchId;
@property(nonatomic,strong)NSString *searchName;
@property(nonatomic,assign)BOOL isSelected;

@end

@interface MainNewListModel : NSObject

@property(nonatomic,strong)NSString *infoTitle;
@property(nonatomic,strong)NSString *mainImage;
@property(nonatomic,strong)NSString *isGood;
@property(nonatomic,strong)NSString *infoReview;
@property(nonatomic,strong)NSString *minPriceRMB;
@property(nonatomic,strong)NSString *declinePercent;
@property(nonatomic,strong)NSString *updateTime;
@property(nonatomic,strong)NSString *mallName;
@property(nonatomic,strong)NSString *infoId;
@property(nonatomic,strong)NSString *countryIcon;


@end

@interface MainHotSpecialListModel : NSObject

@property(nonatomic,strong)NSString *iSpecialID;
@property(nonatomic,strong)NSString *strSpecialName;
@property(nonatomic,strong)NSString *strSpecialImage;

@end

@interface MainBrandSpecialListModel : NSObject

@property(nonatomic,strong)NSString *strBrandName;
@property(nonatomic,strong)NSString *strBrandExclusiveTitle;
@property(nonatomic,strong)NSString *strBrandContent;
@property(nonatomic,strong)NSArray *listRecommendInfo;

@end

@interface MainBrandSpecialGoodsListModel : NSObject

@property(nonatomic,strong)NSString *strInfoTitle;
@property(nonatomic,strong)NSString *decMinPriceRMB;
@property(nonatomic,strong)NSString *strMainImage;
@property(nonatomic,strong)NSString *BrandLogo;
@property(nonatomic,strong)NSString *declinePercent;
@property(nonatomic,strong)NSString *countrySmallIcon;
@property(nonatomic,strong)NSDictionary *mall;

@end
