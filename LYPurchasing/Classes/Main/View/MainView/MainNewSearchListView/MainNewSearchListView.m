//
//  MainNewSearchListView.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainNewSearchListView.h"

@interface MainNewSearchListView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation MainNewSearchListView

- (instancetype)initWithFrame:(CGRect)frame searchListArr:(NSArray *)searchListArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.data = searchListArr;
        
        for (NSInteger i = 0; i < self.data.count; i++) {
            MainNewSearchBarListModel *model = self.data[i];
            if (i == 0) {
                model.isSelected = YES;
            }
        }
        
        [self addSubview:self.collectionView];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, self.frameHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MainNewSearchListCollectionView class] forCellWithReuseIdentifier:@"LISTCELL"];
    }
    return  _collectionView;
}

#pragma mark <----- UICollectionView Delegate dataSource ----->
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainNewSearchListCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LISTCELL" forIndexPath:indexPath];
    cell.model = self.data[indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((MainWidth-3)/4, 35);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (MainNewSearchBarListModel *model in self.data) {
        model.isSelected = NO;
    }
    MainNewSearchBarListModel *model = self.data[indexPath.row];
    if (model.isSelected == NO) {
        model.isSelected = YES;
    }else{
        model.isSelected = !model.isSelected;
    }
    
    [self.collectionView reloadData];
}

@end


@implementation MainNewSearchListCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = RGB16Color(0xFF424242);
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.backgroundColor = BACKGROUNDCOLOR;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        self.titleLabel = titleLabel;
    }
    return self;
}

-(void)setModel:(MainNewSearchBarListModel *)model{
    _model = model;
    self.titleLabel.text = model.searchName;
    [self changeColorState];
}

-(void)changeColorState{
    
    if (self.model.isSelected == NO) {
        self.titleLabel.textColor = RGB16Color(0xFF424242);
        self.titleLabel.backgroundColor = BACKGROUNDCOLOR;
    }else{
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = RGBColor(255, 136, 137);
    }
}

@end

