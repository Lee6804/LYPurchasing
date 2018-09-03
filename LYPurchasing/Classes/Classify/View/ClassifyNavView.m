//
//  ClassifyNavView.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifyNavView.h"

@interface ClassifyNavView()

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *searchImg;
@property(nonatomic,strong)UITextField *searchTF;

@end

@implementation ClassifyNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIView *backView = [UIView new];
    backView.backgroundColor = BACKGROUNDCOLOR;
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(6);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(32);
    }];
    self.backView = backView;
    
    UIImageView *searchImg = [UIImageView new];
    searchImg.image = [UIImage imageNamed:@"搜索"];
    [self.backView addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top).offset(5);
        make.left.mas_equalTo(self.backView.mas_left).offset(8);
        make.width.height.mas_equalTo(22);
    }];
    self.searchImg = searchImg;
    
    UITextField *searchTF = [UITextField new];
    searchTF.font = [UIFont systemFontOfSize:15];
    searchTF.placeholder = @"女包";
    [self.backView addSubview:searchTF];
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchImg);
        make.left.mas_equalTo(self.searchImg.mas_right).offset(10);
        make.right.mas_equalTo(self.backView.mas_right).offset(-10);
        make.height.mas_equalTo(22);
    }];
    self.searchImg = searchImg;
}

@end
