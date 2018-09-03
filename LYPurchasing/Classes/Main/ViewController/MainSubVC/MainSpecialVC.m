//
//  MainSpecialVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainSpecialVC.h"
#import "MainSpecialTopView.h"
#import "MainHotSpecialCell.h"
#import "MainBrandSpecialCell.h"

@interface MainSpecialVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MainSpecialTopView *topView;

@property(nonatomic,assign)NSInteger cellTag;
@property(nonatomic,strong)NSDictionary *hotJsonDic;
@property(nonatomic,strong)NSDictionary *brandJsonDic;
@property(nonatomic,strong)UIScrollView *subScrollView;
@property(nonatomic,strong)UITableView *hotTableView;
@property(nonatomic,strong)NSMutableArray *hotData;
@property(nonatomic,strong)UITableView *brandTableView;
@property(nonatomic,strong)NSMutableArray *brandData;

@end

@implementation MainSpecialVC

-(NSMutableArray *)hotData{
    if (!_hotData) {
        _hotData = [NSMutableArray array];
    }
    return _hotData;
}

-(NSMutableArray *)brandData{
    if (!_brandData) {
        _brandData = [NSMutableArray array];
    }
    return _brandData;
}

-(MainSpecialTopView *)topView{
    if (!_topView) {
        _topView = [[MainSpecialTopView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 80)];
        __weak typeof(self)weakSelf = self;
        _topView.specialTopBtnClickBlock = ^(NSInteger btnTag) {
            
            weakSelf.cellTag = btnTag;
            CGFloat width = btnTag == 1000 ? 0 : MainWidth;
            [weakSelf.subScrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        };
    }
    return _topView;
}

-(UIScrollView *)subScrollView{
    if (!_subScrollView) {
        _subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight- 80)];
        _subScrollView.backgroundColor = TABBACKGCOLOR;
        _subScrollView.scrollEnabled = NO;
        _subScrollView.contentSize = CGSizeMake(MainWidth*2, 0);
        [_subScrollView addSubview:self.hotTableView];
        [_subScrollView addSubview:self.brandTableView];
    }
    return _subScrollView;
}

-(UITableView *)hotTableView{
    if (!_hotTableView) {
        _hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight - 80) style:UITableViewStylePlain];
        _hotTableView.delegate = self;
        _hotTableView.dataSource = self;
        _hotTableView.backgroundColor = TABBACKGCOLOR;
        _hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 10)];
        footerView.backgroundColor = TABBACKGCOLOR;
        _hotTableView.tableFooterView = footerView;
        [_hotTableView registerNib:[UINib nibWithNibName:[MainHotSpecialCell description] bundle:nil] forCellReuseIdentifier:[MainHotSpecialCell description]];
    }
    return _hotTableView;
}

-(UITableView *)brandTableView{
    if (!_brandTableView) {
        _brandTableView = [[UITableView alloc] initWithFrame:CGRectMake(MainWidth, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight - 80) style:UITableViewStyleGrouped];
        _brandTableView.delegate = self;
        _brandTableView.dataSource = self;
        _brandTableView.backgroundColor = TABBACKGCOLOR;
        _brandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _brandTableView.tableFooterView = [[UIView alloc] init];
        [_brandTableView registerClass:[MainBrandSpecialCell class] forCellReuseIdentifier:[MainBrandSpecialCell description]];
    }
    return _brandTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.cellTag = 1000;
    
    self.hotJsonDic = [LYMethod readLocalFileWithName:@"hotSpecial"];
    self.brandJsonDic = [LYMethod readLocalFileWithName:@"brandSpecial"];
    
//    NSLog(@"%@",self.hotJsonDic);
    [self.view addSubview:self.topView];
    [self.view addSubview:self.subScrollView];
    
    self.hotData = [MainHotSpecialListModel mj_objectArrayWithKeyValuesArray:self.hotJsonDic];
    self.brandData = [MainBrandSpecialListModel mj_objectArrayWithKeyValuesArray:self.brandJsonDic];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView == self.hotTableView ? 1 : self.brandData.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0)];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.brandTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 10)];
        view.backgroundColor = TABBACKGCOLOR;
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 0)];
        view.backgroundColor = TABBACKGCOLOR;
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return tableView == self.brandTableView ? 10 : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView == self.hotTableView ? self.hotData.count : 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView == self.hotTableView ? 160 : 334;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (tableView == self.hotTableView) {
        MainHotSpecialCell *listCell = [tableView dequeueReusableCellWithIdentifier:[MainHotSpecialCell description]];
        listCell.model = self.hotData[indexPath.row];
        cell = listCell;
    }else{
        MainBrandSpecialCell *listCell = [tableView dequeueReusableCellWithIdentifier:[MainBrandSpecialCell description]];
        listCell.model = self.brandData[indexPath.section];
        cell = listCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > 80 && self.topView.originY != -80) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.topView.frame = CGRectMake(0, -80, MainWidth, 80);
            self.subScrollView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight);
            if (self.cellTag == 1000) {
                self.hotTableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight);
            }else{
                self.brandTableView.frame = CGRectMake(MainWidth, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight);
            }
            
        }];
    }else if (offsetY < 80 && self.topView.originY == -80) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.topView.frame = CGRectMake(0, 0, MainWidth, 80);
            self.subScrollView.frame = CGRectMake(0, 80, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight - 80);
            if (self.cellTag == 1000) {
                self.hotTableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight - 80);
            }else{
                self.brandTableView.frame = CGRectMake(MainWidth, 0, MainWidth, MainHeight - 30 - LYTopHeight - LYTabBarHeight - 80);
            }
        
        }];
    }
    
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
