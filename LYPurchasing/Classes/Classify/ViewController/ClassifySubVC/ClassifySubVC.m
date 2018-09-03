//
//  ClassifySubVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ClassifySubVC.h"
#import "ClassifyListCollectionViewCell.h"
#import "ClassifyListOtherCollectionViewCell.h"

@interface ClassifySubVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ClassifySubVC

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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator= NO;
        _collectionView.backgroundColor = TABBACKGCOLOR;
        [_collectionView registerNib:[UINib nibWithNibName:[ClassifyListCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:[ClassifyListCollectionViewCell description]];
        [_collectionView registerNib:[UINib nibWithNibName:[ClassifyListOtherCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:[ClassifyListOtherCollectionViewCell description]];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return  _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    NSArray *arr = [ClassifyModel mj_objectArrayWithKeyValuesArray:[LYMethod readLocalFileWithName:@"classify"]];

    for (ClassifyModel *model in arr) {
        model.ListHotTag = [ClassifyListModel mj_objectArrayWithKeyValuesArray:model.ListHotTag];
        [self.data addObject:model];
    }
    
    [self.view addSubview:self.collectionView];
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
        ClassifyModel *model = self.data[indexPath.section];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainWidth - 20, 40)];
        titleLabel.text = model.strGroupName;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor darkGrayColor];
        [reusableView addSubview:titleLabel];
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0.5)];
//        lineView.backgroundColor = BORDERCOLOR;
//        [reusableView addSubview:lineView];
//        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, MainWidth, 0.5)];
//        lineView1.backgroundColor = BORDERCOLOR;
//        [reusableView addSubview:lineView1];
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
    ClassifyModel *model = self.data[section];
    return model.ListHotTag.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (indexPath.section == 0) {
        ClassifyListCollectionViewCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:[ClassifyListCollectionViewCell description] forIndexPath:indexPath];
        ClassifyModel *model = self.data[indexPath.section];
        ClassifyListModel *listModel = model.ListHotTag[indexPath.item];
        listCell.model = listModel;
        cell = listCell;
    }else{
        ClassifyListOtherCollectionViewCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:[ClassifyListOtherCollectionViewCell description] forIndexPath:indexPath];
        ClassifyModel *model = self.data[indexPath.section];
        ClassifyListModel *listModel = model.ListHotTag[indexPath.item];
        listCell.model = listModel;
        cell = listCell;
    }
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(1, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.section == 0 ? CGSizeMake((MainWidth-2)/3, 150) : CGSizeMake((MainWidth-3)/4, (MainWidth-3)/4);
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
