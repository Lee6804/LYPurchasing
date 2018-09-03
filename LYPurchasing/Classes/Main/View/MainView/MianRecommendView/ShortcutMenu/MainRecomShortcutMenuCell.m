//
//  MainRecomShortcutMenuCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomShortcutMenuCell.h"
#import "MainRecomMenuListCollectionViewCell.h"

@interface MainRecomShortcutMenuCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MainRecomShortcutMenuCell

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 80) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.backgroundColor = [UIColor whiteColor];;
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomMenuListCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomMenuListCollectionViewCell description]];
    }
    return  _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

-(void)setModel:(MainModel *)model{
    
    self.data = [MainShortcutMenuListModel mj_objectArrayWithKeyValuesArray:model.itemList];
    [self.collectionView reloadData];
}

#pragma mark <----- UICollectionView Delegate dataSource ----->
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MainRecomMenuListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomMenuListCollectionViewCell description] forIndexPath:indexPath];
    cell.model = self.data[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(MainWidth/4, 80);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

@end
