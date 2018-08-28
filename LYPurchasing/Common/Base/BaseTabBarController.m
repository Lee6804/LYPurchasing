//
//  BaseTabBarController.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/28.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "MainVC.h"
#import "ClassifyVC.h"
#import "RankVC.h"
#import "MineVC.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, LYTabBarHeight)];
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:tabBarView];
    
    [self setupVC];
}

-(void)setupVC{
    
    MainVC *mainVC = [[MainVC alloc] init];
    [self addChildVC:mainVC title:@"首页" normaImgStr:@"main" selectImgStr:@"mainSele"];
    
    ClassifyVC *classifyVC = [[ClassifyVC alloc] init];
    [self addChildVC:classifyVC title:@"分类" normaImgStr:@"category" selectImgStr:@"categorySele"];
    
    RankVC *rankVC = [[RankVC alloc] init];
    [self addChildVC:rankVC title:@"排行" normaImgStr:@"rank" selectImgStr:@"rankSele"];
    
    MineVC *mineVC = [[MineVC alloc] init];
    [self addChildVC:mineVC title:@"我的" normaImgStr:@"mine" selectImgStr:@"mineSele"];
    
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1]} forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MAINCOLOR} forState:UIControlStateNormal];
}

-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title normaImgStr:(NSString *)normalImgStr selectImgStr:(NSString *)selectImgStr {

    self.tabBarItem.title = title;
    self.tabBar.tintColor = [UIColor colorWithRed:216.0/255.0 green:30.0/255.0 blue:6.0/255.0 alpha:1];
    childVC.title = title;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normalImgStr] selectedImage:[UIImage imageNamed:selectImgStr]];
    [self addChildViewController:nav];
    
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
