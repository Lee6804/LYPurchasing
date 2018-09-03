//
//  MainRecomBannerCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomBannerCell.h"

@interface MainRecomBannerCell()

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@end

@implementation MainRecomBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, self.frameHeight)];
        cycleScrollView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:cycleScrollView];
        self.cycleScrollView = cycleScrollView;
        
    }
    return self;

}

-(void)setModel:(MainModel *)model{
    
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in model.itemList) {
        [imgArr addObject:dic[@"imageUrl"]];
    }
    
    self.cycleScrollView.imageURLStringsGroup = imgArr;
}

@end
