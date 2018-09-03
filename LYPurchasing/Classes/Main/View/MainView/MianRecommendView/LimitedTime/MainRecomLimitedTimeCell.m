//
//  MainRecomLimitedTimeCell.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecomLimitedTimeCell.h"
#import "MainRecomLimitedTimeListCell.h"

@interface MainRecomLimitedTimeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *countDownTimeLabel;
@property(nonatomic,strong)UIButton *moreBtn;

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *data;

@property(nonatomic,strong)NSTimer *countDownTimer;
@property(nonatomic,assign)NSInteger secondsCountDown;

@end

@implementation MainRecomLimitedTimeCell

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
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, MainWidth, 150) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.showsHorizontalScrollIndicator= NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomLimitedTimeListCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomLimitedTimeListCell description]];
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
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"限时抢购";
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.height.mas_equalTo(20);
    }];
    self.titleLabel = titleLabel;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BORDERCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(15);
    }];
    self.lineView = lineView;
    
    UILabel *countDownTimeLabel = [UILabel new];
    countDownTimeLabel.text = @"";
    countDownTimeLabel.textColor = [UIColor redColor];
    countDownTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:countDownTimeLabel];
    [countDownTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.titleLabel);
        make.left.mas_equalTo(self.lineView.mas_right).offset(10);
    }];
    self.countDownTimeLabel = countDownTimeLabel;
    
    UIButton *moreBtn = [UIButton new];
    [moreBtn setTitle:@"MORE" forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [self.contentView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    self.moreBtn = moreBtn;
    
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
    
    [self.contentView addSubview:self.collectionView];
}

-(void)countDownAction{
    
    self.secondsCountDown--;
    
    self.countDownTimeLabel.text = [NSString stringWithFormat:@"仅剩 %@",[LYMethod getMMSSFromSS:[NSString stringWithFormat:@"%ld",self.secondsCountDown]]];
    
    //当倒计时到0时做需要的操作
    if(self.secondsCountDown==0){
        [self.countDownTimer invalidate];
    }
}

-(void)setModel:(MainModel *)model{
    
    _model = model;
    NSArray *arr = model.item[@"goods"];
    self.data = [MainRecomLimitedTimeGoodsListModel mj_objectArrayWithKeyValuesArray:arr];
    self.secondsCountDown = [model.item[@"countDown"] integerValue];
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
    MainRecomLimitedTimeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomLimitedTimeListCell description] forIndexPath:indexPath];
    cell.model = self.data[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(120, 150);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
