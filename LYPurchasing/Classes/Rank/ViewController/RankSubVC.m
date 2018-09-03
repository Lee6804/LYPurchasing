//
//  RankSubVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "RankSubVC.h"
#import "RankGoodsListCell.h"

@interface RankSubVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation RankSubVC

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight - LYTopHeight - LYTabBarHeight - 40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = TABBACKGCOLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:[RankGoodsListCell description] bundle:nil] forCellReuseIdentifier:[RankGoodsListCell description]];
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.titleStr);
}

-(void)loadData:(NSInteger)tag{
    
    NSDictionary *dic = [LYMethod readLocalFileWithName:@"rank"];
    self.data = [RankGoodsListModel mj_objectArrayWithKeyValuesArray:dic[@"result"][@"infolist"]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];

    [self.view addSubview:self.tableView];
    [self loadData:0];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView0{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankGoodsListCell *listCell = [tableView dequeueReusableCellWithIdentifier:[RankGoodsListCell description]];
    listCell.model = self.data[indexPath.row];
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
