//
//  MainVC.m
//  LYPurchasing
//
//  Created by Lee on 2018/8/28.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "MainVC.h"
#import "MainNavView.h"

#import "MainRecommendVC.h"
#import "MainNewVC.h"
#import "MainSpecialVC.h"

#define pageMenuH 30
#define NaviH (kScreenIphoneX ? 88 : 64) // 812是iPhoneX的高度
#define scrollViewHeight (MainHeight-88-pageMenuH)

@interface MainVC ()<SPPageMenuDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)MainNavView *navView;

@property(nonatomic,strong)NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;

@end

@implementation MainVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.shadowImage = nil;
}

-(MainNavView *)navView{
    if (!_navView) {
        _navView = [[MainNavView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 44)];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar addSubview:self.navView];
    
    [self initVC];
}

-(void)initVC{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, pageMenuH)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.dataArr = @[@"推荐",@"最新",@"专场"];
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(MainWidth/2 - 100, 0, 200, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.selectedItemTitleColor = MAINCOLOR;
    pageMenu.tracker.backgroundColor = MAINCOLOR;
    pageMenu.trackerWidth = 30;
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.itemTitleFont = [UIFont systemFontOfSize:15];
    pageMenu.unSelectedItemTitleColor = RGB16Color(0xFF424242);
    pageMenu.dividingLineHeight = 0;
    pageMenu.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    pageMenu.selectedItemZoomScale = 1.1;
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    NSArray *controllerClassNames = [NSArray arrayWithObjects:@"MainRecommendVC",@"MainNewVC",@"MainSpecialVC", nil];
    for (int i = 0; i < self.dataArr.count; i++) {
        if (controllerClassNames.count > i) {
            BaseViewController *baseVc = [[NSClassFromString(controllerClassNames[i]) alloc] init];
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
        BaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(MainWidth*self.pageMenu.selectedItemIndex, 0, MainWidth, MainHeight - LYTabBarHeight);
        scrollView.contentOffset = CGPointMake(MainWidth*self.pageMenu.selectedItemIndex, 0);
        scrollView.contentSize = CGSizeMake(self.dataArr.count*MainWidth, 0);
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
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
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

- (void)dealloc {
    NSLog(@"父控制器被销毁了");
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
