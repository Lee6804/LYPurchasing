//
//  MainBrandSpecialCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainBrandSpecialCell.h"
#import "MainBrandSpecialGoodsCell.h"

@interface MainBrandSpecialCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)UILabel *brandNameLabel;
@property(nonatomic,strong)UILabel *brandExclusiveTitleLabel;
@property(nonatomic,strong)UILabel *brandContentLabel;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *data;

@end

@implementation MainBrandSpecialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    UIImageView *logoImg = [UIImageView new];
    [self.contentView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.height.mas_equalTo(40);
    }];
    self.logoImg = logoImg;
    
    UILabel *brandNameLabel = [UILabel new];
    brandNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:brandNameLabel];
    [brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg);
        make.left.mas_equalTo(self.logoImg.mas_right).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    self.brandNameLabel = brandNameLabel;
    
    UILabel *brandExclusiveTitleLabel = [UILabel new];
    brandExclusiveTitleLabel.font = [UIFont systemFontOfSize:12];
    brandExclusiveTitleLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:brandExclusiveTitleLabel];
    [brandExclusiveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.brandNameLabel.mas_bottom);
        make.left.right.equalTo(self.brandNameLabel);
        make.height.mas_equalTo(20);
    }];
    self.brandExclusiveTitleLabel = brandExclusiveTitleLabel;
    
    UILabel *brandContentLabel = [UILabel new];
    brandContentLabel.font = [UIFont systemFontOfSize:13];
    brandContentLabel.textColor = [UIColor darkGrayColor];
    brandContentLabel.numberOfLines = 0;
    [self.contentView addSubview:brandContentLabel];
    [brandContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImg.mas_bottom).offset(8);
        make.left.equalTo(self.logoImg);
        make.right.equalTo(self.brandNameLabel);
        make.height.mas_equalTo(35);
    }];
    self.brandContentLabel = brandContentLabel;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 101, MainWidth, 233) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator= NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:[MainBrandSpecialGoodsCell description] bundle:nil] forCellWithReuseIdentifier:[MainBrandSpecialGoodsCell description]];
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
}


-(void)setModel:(MainBrandSpecialListModel *)model{
    
    self.brandNameLabel.text = model.strBrandName;
    self.brandExclusiveTitleLabel.text = model.strBrandExclusiveTitle;
    self.brandContentLabel.text = model.strBrandContent;
    
    self.data = [MainBrandSpecialGoodsListModel mj_objectArrayWithKeyValuesArray:model.listRecommendInfo];
    [self.collectionView reloadData];
    
    MainBrandSpecialGoodsListModel *goodsModel = self.data[0];
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.BrandLogo] placeholderImage:[UIImage imageNamed:@"photo"]];
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
    cell.model = self.data[indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(130, 233);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
