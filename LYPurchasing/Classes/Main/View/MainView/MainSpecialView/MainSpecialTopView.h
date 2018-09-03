//
//  MainSpecialTopView.h
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^specialTopBtnClickBlock)(NSInteger btnTag);

@interface MainSpecialTopView : UIView

@property(nonatomic,copy)specialTopBtnClickBlock specialTopBtnClickBlock;

@end
