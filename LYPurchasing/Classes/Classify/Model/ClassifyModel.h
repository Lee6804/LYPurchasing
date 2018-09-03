//
//  ClassifyModel.h
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject

@property(nonatomic,strong)NSString *strGroupName;
@property(nonatomic,strong)NSArray *ListHotTag;

@end

@interface ClassifyListModel : NSObject

@property(nonatomic,strong)NSString *strTagName;
@property(nonatomic,strong)NSString *strTagDes;
@property(nonatomic,strong)NSString *strTagImage;

@end

@interface ClassifyBrandModel : NSObject

@property(nonatomic,strong)NSString *catname;
@property(nonatomic,strong)NSArray *result;

@end

@interface ClassifyBrandListModel : NSObject

@property(nonatomic,strong)NSString *strBrandName;
@property(nonatomic,strong)NSString *strBrandEngName;
@property(nonatomic,strong)NSString *strBrandLogo;

@end
