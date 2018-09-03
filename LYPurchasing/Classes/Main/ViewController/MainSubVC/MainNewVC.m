//
//  MainNewVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainNewVC.h"
#import "MainModel.h"
#import "MainNewSearchListView.h"
#import "MainNewListCell.h"

@interface MainNewVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *jsonDic;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation MainNewVC

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 71, MainWidth, MainHeight - 30 - 71 - LYTopHeight - LYTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = TABBACKGCOLOR;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:[MainNewListCell description] bundle:nil] forCellReuseIdentifier:[MainNewListCell description]];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    self.jsonDic = [LYMethod readLocalFileWithName:@"new1"];
    
//    NSLog(@"%@",self.jsonDic);
    
    MainNewSearchListView *listView = [[MainNewSearchListView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 71) searchListArr:[MainNewSearchBarListModel mj_objectArrayWithKeyValuesArray:self.jsonDic[@"data"][@"searchBarList"]]];
    [self.view addSubview:listView];
    
    self.data = [MainNewListModel mj_objectArrayWithKeyValuesArray:self.jsonDic[@"data"][@"productList"]];
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainNewListCell *listCell = [tableView dequeueReusableCellWithIdentifier:[MainNewListCell description]];
    listCell.model = self.data[indexPath.row];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return listCell;
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
