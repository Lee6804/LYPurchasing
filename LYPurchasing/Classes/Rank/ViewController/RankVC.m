//
//  RankVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/28.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "RankVC.h"
#import "RankSubVC.h"

#define pageMenuH 40
#define NaviH (kScreenIphoneX ? 88 : 64) // 812是iPhoneX的高度
#define scrollViewHeight (MainHeight-88-pageMenuH)

@interface RankVC ()<SPPageMenuDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *listNameArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;

@end

@implementation RankVC

-(NSMutableArray *)listNameArr{
    if (!_listNameArr) {
        _listNameArr = [NSMutableArray array];
    }
    return _listNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"热销榜";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self initVC];
}

-(void)initVC{
    
    NSDictionary *rankListDic = [LYMethod readLocalFileWithName:@"rankList"];
    NSArray *arr = rankListDic[@"result"][@"infolist"];
    for (NSDictionary *dic in arr) {
        [self.listNameArr addObject:dic[@"CatName"]];
    }
    
    NSMutableArray *controllerClassNames = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.listNameArr.count; i++) {
        [controllerClassNames addObject:@"RankSubVC"];
    }
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, MainWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    [pageMenu setItems:self.listNameArr selectedItemIndex:0];
    pageMenu.selectedItemTitleColor = MAINCOLOR;
    pageMenu.tracker.backgroundColor = MAINCOLOR;
    pageMenu.trackerWidth = 30;
    pageMenu.itemTitleFont = [UIFont systemFontOfSize:15];
    pageMenu.unSelectedItemTitleColor = RGB16Color(0xFF424242);
    pageMenu.showFuntionButton = YES;
    [pageMenu setFunctionButtonTitle:nil image:[UIImage imageNamed:@"down"] imagePosition:SPItemImagePositionDefault imageRatio:0 forState:UIControlStateNormal];
    pageMenu.selectedItemZoomScale = 1.1;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    for (int i = 0; i < self.listNameArr.count; i++) {
        if (controllerClassNames.count > i) {
            RankSubVC *baseVc = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            baseVc.titleStr = self.listNameArr[i];
            [self addChildViewController:baseVc];
            // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
            [self.myChildViewControllers addObject:baseVc];
        }
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageMenuH, MainWidth, MainHeight - LYTabBarHeight)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        RankSubVC *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(MainWidth*self.pageMenu.selectedItemIndex, 0, MainWidth, MainHeight - LYTabBarHeight);
        scrollView.contentOffset = CGPointMake(MainWidth*self.pageMenu.selectedItemIndex, 0);
        scrollView.contentSize = CGSizeMake(self.listNameArr.count*MainWidth, 0);
    }
}

#pragma mark - SPPageMenu的代理方法

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    //    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(MainWidth * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(MainWidth * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    RankSubVC *targetViewController = (RankSubVC *)self.myChildViewControllers[toIndex];
    targetViewController.titleStr = self.listNameArr[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.frame = CGRectMake(MainWidth * toIndex, 0, MainWidth, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
}

#pragma mark - getter
- (NSMutableArray *)myChildViewControllers {
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
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
