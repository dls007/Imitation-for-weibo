//
//  mainViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "mainViewController.h"
//#import "HomeViewController.h"
#import "MyHomeViewController.h"
#import "MessageViewController.h"
#import "FriendsViewController.h"
#import "SearchViewController.h"
#import "SettingViewController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"
#import "ThemeButton.h"
#import "UIFactory.h"
#import "ThemeImageView.h"


#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

@interface mainViewController ()

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadViewControllers];
    
    // 自定义tabBar视图
    [self customTabBarView];

 //weibo 相关
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    relationshipButton = [[WBSDKRelationshipButton alloc] initWithFrame:CGRectMake(20, 550, 140, 30) accessToken:myDelegate.wbtoken currentUser:myDelegate.wbCurrentUserID followUser:@"2002619624" completionHandler:^(WBSDKBasicButton *button, BOOL isSuccess, NSDictionary *resultDict) {
//        
//        NSString* accessToken = [resultDict objectForKey:@"access_token"];
//        if (accessToken)
//        {
//            myDelegate.wbtoken = accessToken;
//        }
//        NSString* uid = [resultDict objectForKey:@"uid"];
//        if (uid)
//        {
//            myDelegate.wbCurrentUserID = uid;
//        }
//        
//        
//    }];
//
//    
    //每60秒请求未读数据
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
    
}
- (void)timerAction:(NSTimer *)timer {
    [self loadUnreadDate];
}

- (void)loadUnreadDate {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadViewControllers
{
    /**
     *  @ 1 创建视图控制器
     *    2 创建tabBarItem->ViewController
     *    3 ViewController作为NavigationController根视图(基栈)
     *    4 NavigationController -> array
     *    5 通过setViewControllers:animated:
     */
    
    // 主页

    
    ViewController *VC = [[ViewController alloc]init];
    
    MyHomeViewController *myHomeViewController = [[MyHomeViewController alloc]init];
    
    
    BaseNavigationController *homeNavigation = [[BaseNavigationController alloc] initWithRootViewController:myHomeViewController];

    
    // 消息
    MessageViewController *messageViewController = [[MessageViewController alloc] init];
    BaseNavigationController *messageNavigation = [[BaseNavigationController alloc] initWithRootViewController:messageViewController];
    
    // 好友
    FriendsViewController *friendsViewController = [[FriendsViewController alloc] init];
    BaseNavigationController *friendsNavigation = [[BaseNavigationController alloc] initWithRootViewController:friendsViewController];

    
    // 搜索
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    UINavigationController *searchNavigation = [[BaseNavigationController alloc] initWithRootViewController:searchViewController];

    
    // 设置
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    BaseNavigationController *settingNavigation = [[BaseNavigationController alloc] initWithRootViewController:settingViewController];

    
    // 内存管理的基本原则(没有看到这几个关键字眼时，alloc copy retain，没有拥有对象的所有权)
    
    
    
    
    
    NSArray *viewControllers = @[homeNavigation, messageNavigation, friendsNavigation, searchNavigation, settingNavigation];
  
    
    [self setViewControllers:viewControllers animated:YES];
    
    // wrong eg.
    /*
     USAViewController *usaViewController = [[USAViewController alloc] init];
     NewsViewController *newsViewController = [[NewsViewController alloc] init];
     TopViewController *topViewController = [[TopViewController alloc] init];
     CinemaViewController *cinemaViewController = [[CinemaViewController alloc] init];
     MoreViewController *moreViewController = [[MoreViewController alloc] init];
     
     NSArray *viewControllers = @[usaViewController, newsViewController, topViewController, cinemaViewController, moreViewController];
     [usaViewController release];
     [newsViewController release];
     [topViewController release];
     [cinemaViewController release];
     [moreViewController release];
     
     [self setViewControllers:viewControllers animated:YES];
     */
}

- (void)customTabBarView
{
    // 自定义tabBar背景视图
    
    
    _tabBarBG = [UIFactory createThemeImage:@"tab_bg_all"];
    _tabBarBG.frame = CGRectMake(0, kDeviceHeight-59, kDeviceWidth, 59);

    
    
//    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-59, kDeviceWidth, 59)];
    _tabBarBG.userInteractionEnabled = YES;
//    _tabBarBG.image = [UIImage imageNamed:@"tab_bg_all"];
    [self.view addSubview:_tabBarBG];
    
    // 选中视图
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 2, 50, 59)];
    _selectView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_tabBarBG addSubview:_selectView];
    
    // 整理数据
    NSArray *imgs   = @[@"home", @"message", @"friends", @"search", @"setting"];
    NSArray *titles = @[@"     主页", @"     消息", @"      好友", @"     搜索", @"     设置"];
    
    int x = 0;
    for (int index = 0; index < 5; index++) {
        
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(3+x, 0, 50, 45)];
        itemView.tag = index;
        [itemView.itemBtn addTarget:self action:@selector(moveSelectView:) forControlEvents:UIControlEventTouchUpInside];
        itemView.delegate = self; // 设置委托
        //设置对应的tabBarItem
        [itemView.itemBtn setImageName:imgs[index]];
        itemView.itemBtn.tag = index;
        itemView.title.text = titles[index];
        [_tabBarBG addSubview:itemView];
  
        
        x += 85;
    }
}
-(void)moveSelectView:(ThemeButton *)btn
{
    int index = (int)btn.superview.tag;
//    NSLog(@"%d",index);
    [UIView beginAnimations:nil context:NULL];
    _selectView.frame = CGRectMake(17 + 85 * index, 2, 50, 59);
    [UIView commitAnimations];
    
    self.selectedIndex = index;
    //    //判断是否重复点击
//    if (btn.tag == self.selectedIndex ) {
//        UINavigationController *homeNav = [self.viewControllers objectAtIndex:0];
//        MyHomeViewController *homeCtl = [homeNav.viewControllers objectAtIndex:0];
//        [homeCtl headerRereshing];
//    }
    
}
#pragma mark - ItemView Delegate
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index
{
    [UIView beginAnimations:nil context:NULL];
    _selectView.frame = CGRectMake(17 + 85 * index, 2, 50, 59);
    [UIView commitAnimations];
    self.selectedIndex = index;

}




@end
