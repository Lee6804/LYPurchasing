//
//  MainRecommendVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainRecommendVC.h"
#import "MainRecomBannerCell.h"//banner
#import "MainRecomShortcutMenuCell.h"//快捷菜单
#import "MainRecomDividingLineCell.h"//分割线
#import "MainRecomTitleIntervalCell.h"//标题区间
#import "MainRecomNewOrderCell.h"//最新订单
#import "MainRecomLimitedTimeCell.h"//限时抢购
#import "MainRecomGroupBuyListCell.h"//组团拼团
#import "MainRecomCheckMoreCell.h"//查看更多
#import "MainRecomHotSpecialCell.h"//热门专场
#import "MainRecomMoreGoodsCell.h"//更多商品

@interface MainRecommendVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSDictionary *jsonDic;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger totalPage;

@end

@implementation MainRecommendVC

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.backgroundColor = TABBACKGCOLOR;
        [_collectionView registerClass:[MainRecomBannerCell class] forCellWithReuseIdentifier:[MainRecomBannerCell description]];
        [_collectionView registerClass:[MainRecomShortcutMenuCell class] forCellWithReuseIdentifier:[MainRecomShortcutMenuCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomDividingLineCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomDividingLineCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomTitleIntervalCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomTitleIntervalCell description]];
        [_collectionView registerClass:[MainRecomNewOrderCell class] forCellWithReuseIdentifier:[MainRecomNewOrderCell description]];
        [_collectionView registerClass:[MainRecomLimitedTimeCell class] forCellWithReuseIdentifier:[MainRecomLimitedTimeCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomGroupBuyListCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomGroupBuyListCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomCheckMoreCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomCheckMoreCell description]];
        [_collectionView registerClass:[MainRecomHotSpecialCell class] forCellWithReuseIdentifier:[MainRecomHotSpecialCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[MainRecomMoreGoodsCell description] bundle:nil] forCellWithReuseIdentifier:[MainRecomMoreGoodsCell description]];
    }
    return  _collectionView;
}

-(void)setRefreshView:(UICollectionView *)collectionView{
    
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.pageNum = 1;
            [self laodData:self.pageNum];
            [collectionView.mj_header endRefreshing];
            [collectionView.mj_footer endRefreshing];
        });
        
    }];
    
    collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageNum += 1;
        if (self.pageNum >self.totalPage) {
            [collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self laodData:self.pageNum];
            [collectionView.mj_footer endRefreshing];
        }
    }];
}

-(void)laodData:(NSInteger)page{
    
    self.jsonDic = [LYMethod readLocalFileWithName:[NSString stringWithFormat:@"recommend%ld",page]];
    
    BOOL isHave = NO;
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.jsonDic[@"data"][@"list"]) {
        if ([dic[@"viewCode"] integerValue] != 207) {
            [mutArr addObject:dic];
        }else{
            isHave = YES;
        }
    }
    
    if (isHave == YES) {
        NSMutableArray *itemArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        for (NSDictionary *dic in self.jsonDic[@"data"][@"list"]) {
            if ([dic[@"viewCode"] integerValue] == 207) {
                [itemArr addObject:dic[@"item"]];
            }
        }
        [dic setObject:@"207" forKey:@"viewCode"];
        [dic setObject:itemArr forKey:@"itemList"];
        
        [mutArr addObject:dic];
    }
    
    
    NSArray *arr = [MainModel mj_objectArrayWithKeyValuesArray:mutArr];
    
    if (page == 1) {
        
        [self.data removeAllObjects];
    }
    
    for (MainModel *model in arr) {
        if (model.viewCode == 207) {
            model.itemList = [MainNewListModel mj_objectArrayWithKeyValuesArray:model.itemList];
        }
        [self.data addObject:model];
    }
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.pageNum = 1;
    self.totalPage = 4;

    [self.view addSubview:self.collectionView];
    [self laodData:self.pageNum];
    [self setRefreshView:self.collectionView];
    
    self.jsonDic = [LYMethod readLocalFileWithName:@"recommend4"];
    
    NSArray *arr = self.jsonDic[@"data"][@"list"];
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dic in arr) {
        if ([dic[@"viewCode"] integerValue] == 207) {
            [mutArr addObject:dic[@"item"]];
        }
    }
    [dic setObject:@"207" forKey:@"viewCode"];
    [dic setObject:mutArr forKey:@"itemList"];
    
//    NSLog(@"%@",dic);
    
}

#pragma mark <----- UICollectionView Delegate dataSource ----->
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MainModel *model = self.data[section];
    return model.viewCode == 207 ? model.itemList.count : 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    MainModel *model = self.data[indexPath.section];
    switch (model.viewCode) {
        case 101:{//banner
            MainRecomBannerCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomBannerCell description] forIndexPath:indexPath];
            bannerCell.model = self.data[indexPath.section];
            cell = bannerCell;
        }
            break;
        case 102:{//快捷菜单
             MainRecomShortcutMenuCell *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomShortcutMenuCell description] forIndexPath:indexPath];
            menuCell.model = self.data[indexPath.section];
            cell = menuCell;
        }
            break;
        case 1:{//分隔线
            MainRecomDividingLineCell *lineCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomDividingLineCell description] forIndexPath:indexPath];
            cell = lineCell;
        }
            break;
        case 105:{//标题区间
            MainRecomTitleIntervalCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomTitleIntervalCell description] forIndexPath:indexPath];
            titleCell.model = self.data[indexPath.section];
            cell = titleCell;
        }
            break;
        case 201:{//最新订单
            MainRecomNewOrderCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomNewOrderCell description] forIndexPath:indexPath];
            orderCell.model = self.data[indexPath.section];
            cell = orderCell;
        }
            break;
        case 208:{//限时抢购
            MainRecomLimitedTimeCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomLimitedTimeCell description] forIndexPath:indexPath];
            orderCell.model = self.data[indexPath.section];
            cell = orderCell;
        }
            break;
        case 209:{//组团拼团
            MainRecomGroupBuyListCell *groupBuyCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomGroupBuyListCell description] forIndexPath:indexPath];
            groupBuyCell.model = self.data[indexPath.section];
            cell = groupBuyCell;
        }
            break;
        case 103:{//查看更多
            MainRecomCheckMoreCell *checkMoreCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomCheckMoreCell description] forIndexPath:indexPath];
            checkMoreCell.model = self.data[indexPath.section];
            cell = checkMoreCell;
        }
            break;
        case 202:case 203:{//热门专场&&品牌专场
            MainRecomHotSpecialCell *hotSpecialCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomHotSpecialCell description] forIndexPath:indexPath];
            hotSpecialCell.model = self.data[indexPath.section];
            cell = hotSpecialCell;
        }
            break;
        case 207:{//更多商品
            MainRecomMoreGoodsCell *moreGoodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainRecomMoreGoodsCell description] forIndexPath:indexPath];
            moreGoodsCell.model = model.itemList[indexPath.row];
            cell = moreGoodsCell;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    MainModel *model = self.data[section];
    return model.viewCode == 207 ? UIEdgeInsetsMake(0, 10, 10, 10) :UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size;
    
    MainModel *model = self.data[indexPath.section];
   
    switch (model.viewCode) {
        case 101://banner
            size = CGSizeMake(MainWidth, MainWidth*378/750);
            break;
        case 102://menu
            size = CGSizeMake(MainWidth, 80);
            break;
        case 1://分隔线
            size = CGSizeMake(MainWidth, 10);
            break;
        case 105://标题区间
            size = CGSizeMake(MainWidth, 50);
            break;
        case 201://最新订单
            size = CGSizeMake(MainWidth, 92);
            break;
        case 208://限时抢购
            size = CGSizeMake(MainWidth, 190);
            break;
        case 209://组团拼团
            size = CGSizeMake(MainWidth, 140);
            break;
        case 103://查看更多
            size = CGSizeMake(MainWidth, MainWidth*100/750);
            break;
        case 202://热门专场
            size = CGSizeMake(MainWidth, MainWidth*320/800 + 253);
            break;
        case 203://品牌专场
            size = CGSizeMake(MainWidth, MainWidth*480/800 + 253);
            break;
        case 207://品牌专场
            size = CGSizeMake((MainWidth-30)/2, (MainWidth-30)/2 + 110);
            break;
        default:
            break;
    }
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
