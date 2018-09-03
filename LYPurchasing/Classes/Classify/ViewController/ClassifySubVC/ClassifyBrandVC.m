//
//  ClassifyBrandVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifyBrandVC.h"
#import "ClassifyListOtherCollectionViewCell.h"
#import "ClassifyNameListCell.h"

@interface ClassifyBrandVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *tabData;

@end

@implementation ClassifyBrandVC

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(NSMutableArray *)tabData{
    if (!_tabData) {
        _tabData = [NSMutableArray array];
    }
    return _tabData;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth - 10, 200) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.backgroundColor = TABBACKGCOLOR;
        [_collectionView registerNib:[UINib nibWithNibName:[ClassifyListOtherCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:[ClassifyListOtherCollectionViewCell description]];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return  _collectionView;
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectZero];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView addSubview:self.collectionView];
    }
    return _headView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = TABBACKGCOLOR;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:[ClassifyNameListCell description] bundle:nil] forCellReuseIdentifier:[ClassifyNameListCell description]];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dic = [LYMethod readLocalFileWithName:@"classifyBrand"];
    NSArray *arr = [ClassifyBrandModel mj_objectArrayWithKeyValuesArray:dic[@"result"]];
    
    for (ClassifyBrandModel *model in arr) {
        model.result = [ClassifyBrandListModel mj_objectArrayWithKeyValuesArray:model.result];
        [self.data addObject:model];
    }
    
//    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.tableView];
    self.headView.frame = CGRectMake(0, 0, MainWidth, (2*((MainWidth-3)-10)/4)*self.data.count + 40*self.data.count + 10*self.data.count + 2*self.data.count);
    self.collectionView.frame = CGRectMake(0, 0, MainWidth - 10, (2*((MainWidth-3)-10)/4)*self.data.count + 40*self.data.count + 10*self.data.count + 2*self.data.count);
    
    NSArray *contentArr = [LYMethod readLocalFileWithName:@"brandContent"];
    
    
    //第一步:去掉名字和首字符为空的元素
    NSMutableArray *testArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in contentArr) {
        if (![dic[@"BrandName"] isEqualToString:@""] && ![dic[@"BrandLetter"] isEqualToString:@""]) {
            [testArr addObject:dic];
        }
    }
//    NSLog(@"%@",testArr);
    
    //第二步:遍历取出首字符字段放入数组
    NSMutableArray *newMutArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in testArr) {
        NSMutableDictionary *testDic = [[NSMutableDictionary alloc] init];
        [testDic setObject:dic[@"BrandLetter"] forKey:@"initials"];
        if ([newMutArr containsObject:testDic] == NO) {
            [newMutArr addObject:testDic];
        }
    }
    
//    NSLog(@"%@",newMutArr);
    
    //第三步:在存放首字符的基础上进行遍历,如果总数据源中的首字符与上面存放的相同,则做相应操作,并最后存放到数组
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (NSDictionary *newDic in newMutArr) {
        NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
        NSMutableArray *newContentArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in testArr) {
            NSMutableDictionary *newContentDic = [[NSMutableDictionary alloc] init];
            if ([dic[@"BrandLetter"] isEqualToString:newDic[@"initials"]]) {
                [newContentDic setObject:dic[@"BrandName"] forKey:@"strBrandName"];
                [newContentDic setObject:dic[@"BrandLogo"] forKey:@"strBrandLogo"];
                [newContentDic setObject:dic[@"BrandEngName"] forKey:@"strBrandEngName"];
                if ([newContentArr containsObject:newContentDic] == NO) {
                    [newContentArr addObject:newContentDic];
                }
            }
        }
        [resultDic setObject:newDic[@"initials"] forKey:@"catname"];
        [resultDic setObject:newContentArr forKey:@"result"];
        if ([resultArr containsObject:resultDic] == NO) {
            [resultArr addObject:resultDic];
        }
    }
    
//    NSLog(@"%@",resultArr);
    
    NSArray *tabArr = [ClassifyBrandModel mj_objectArrayWithKeyValuesArray:resultArr];
    for (ClassifyBrandModel *model in tabArr) {
        model.result = [ClassifyBrandListModel mj_objectArrayWithKeyValuesArray:model.result];
        [self.tabData addObject:model];
    }
}




#pragma mark <----- UICollectionView Delegate dataSource ----->
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView;
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        ClassifyBrandModel *model = self.data[indexPath.section];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainWidth - 20, 40)];
        titleLabel.text = model.catname;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor darkGrayColor];
        [reusableView addSubview:titleLabel];
        
    }else if (kind == UICollectionElementKindSectionFooter) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    }
    
    return reusableView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 10);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ClassifyBrandModel *model = self.data[section];
    return model.result.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell;

    ClassifyListOtherCollectionViewCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:[ClassifyListOtherCollectionViewCell description] forIndexPath:indexPath];
    ClassifyBrandModel *model = self.data[indexPath.section];
    ClassifyBrandListModel *listModel = model.result[indexPath.item];
    listCell.brandModel = listModel;
    cell = listCell;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(((MainWidth-3)-10)/4, ((MainWidth-3)-10)/4);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - UITableView deldgate,dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tabData.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 30)];
    view.backgroundColor = TABBACKGCOLOR;
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    ClassifyBrandModel *model = self.tabData[section];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainWidth - 20, 30)];
    titleLabel.text = model.catname;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor darkGrayColor];
    [view addSubview:titleLabel];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ClassifyBrandModel *model = self.tabData[section];
    return model.result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassifyNameListCell *listCell = [tableView dequeueReusableCellWithIdentifier:[ClassifyNameListCell description]];
    ClassifyBrandModel *model = self.tabData[indexPath.section];
    ClassifyBrandListModel *listModel = model.result[indexPath.row];
    listCell.model = listModel;
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return listCell;
}

//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    ClassifyBrandModel *model = self.tabData[section];
    return model.catname;
}

//返回索引数组
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (ClassifyBrandModel *model in self.tabData) {
        [arr addObject:model.catname];
    }
    return arr;
}

//响应点击索引时的委托方法
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    
//}

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
