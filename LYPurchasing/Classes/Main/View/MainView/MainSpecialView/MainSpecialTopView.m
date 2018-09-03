//
//  MainSpecialTopView.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainSpecialTopView.h"

@interface MainSpecialTopView()

@property(nonatomic,strong)NSMutableArray *btnArr;

@end

@implementation MainSpecialTopView

-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0.5)];
    lineView.backgroundColor = BORDERCOLOR;
    [self addSubview:lineView];
    
    NSArray *arr = @[@"热门专场",@"品牌专场"];
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton  buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20 + (20 + (MainWidth-60)/2)*i, self.frameHeight/2 - 18, (MainWidth-60)/2, 36);
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 18;
        btn.layer.borderColor = BORDERCOLOR.CGColor;
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0.5;
        [self addSubview:btn];
        [self.btnArr addObject:btn];
    }
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frameHeight - 0.5, MainWidth, 0.5)];
    lineView1.backgroundColor = BORDERCOLOR;
    [self addSubview:lineView1];
    
    ((UIButton *)[self.btnArr objectAtIndex:0]).selected = YES;
    ((UIButton *)[self.btnArr objectAtIndex:0]).backgroundColor = MAINCOLOR;
}

-(void)btnClick:(UIButton *)btn{
    
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        obj.backgroundColor = [UIColor whiteColor];
    }];
    
    if (btn.selected == NO) {
        btn.selected = YES;
        btn.backgroundColor = MAINCOLOR;
    }
    
    !_specialTopBtnClickBlock ? : _specialTopBtnClickBlock(btn.tag);
}

@end
