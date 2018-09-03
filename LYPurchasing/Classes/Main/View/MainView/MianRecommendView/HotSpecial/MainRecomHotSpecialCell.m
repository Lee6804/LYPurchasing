//
//  MainRecomHotSpecialCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomHotSpecialCell.h"
#import "MainBrandSpecialGoodsCell.h"

@interface MainRecomHotSpecialCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIImageView *headImg;
@property(nonatomic,strong)UIImageView *tagImg;

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MainRecomHotSpecialCell

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 30, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, MainWidth*320/800 + 20, MainWidth, 233) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.showsHorizontalScrollIndicator= NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:[MainBrandSpecialGoodsCell description] bundle:nil] forCellWithReuseIdentifier:[MainBrandSpecialGoodsCell description]];
    }
    return  _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *headImg = [UIImageView new];
    [self.contentView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(MainWidth*320/800);
    }];
    self.headImg = headImg;
    
    UIImageView *tagImg = [UIImageView new];
    tagImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:tagImg];
    [tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(21);
    }];
    self.tagImg = tagImg;
    
    [self.contentView addSubview:self.collectionView];
}

-(void)setModel:(MainModel *)model{
    _model = model;

    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    if (model.viewCode == 203) {
        [self.headImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MainWidth*480/800);
        }];
        self.tagImg.hidden = YES;
        self.collectionView.frame = CGRectMake(0, MainWidth*480/800 + 20, MainWidth, 233);
    }else{
        [self.headImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(MainWidth*320/800);
        }];
        self.tagImg.hidden = NO;
        [self.tagImg sd_setImageWithURL:[NSURL URLWithString:model.tagImageUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
        self.collectionView.frame = CGRectMake(0, MainWidth*320/800 + 20, MainWidth, 233);
    }
    
    self.data = [MainRecomHotSpecialGoodsListModel mj_objectArrayWithKeyValuesArray:model.itemList];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
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
    MainBrandSpecialGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainBrandSpecialGoodsCell description] forIndexPath:indexPath];
    cell.recomModel = self.data[indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(130, 233);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
