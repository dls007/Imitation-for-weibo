//
//  MyHomeViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/22.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "MyHomeViewController.h"
#import "ViewController.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "UIImageView+webCatch.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "CONSTS.h"
//#import "UserViewController.h"

@interface MyHomeViewController ()
@property (nonatomic, strong) NSMutableArray *statuses;
//@property (nonatomic, strong) NSMutableArray *statusImage;
//@property (nonatomic,copy)NSString *lastWeiboId;

@end


@implementation MyHomeViewController
{
    WeiboRequestOperation *_query;
    ViewController *vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOME";
    self.view.backgroundColor = [UIColor lightGrayColor];
    //监听图片浏览模式
    [[NSNotificationCenter defaultCenter]addObserver:self.tableView selector:@selector(reloadData) name:kReloadWeiboTableViewNotification object:nil];
    
   
    UIBarButtonItem *bindBtn = [[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = bindBtn;
    
    UIBarButtonItem *signoutBtn =[[UIBarButtonItem alloc]initWithTitle:@"注销账号" style:UIBarButtonItemStylePlain target:self action:@selector(signoutAction:)];
    self.navigationItem.leftBarButtonItem = signoutBtn;
//    [self showWithProgress:nil];
    [self showHUD];
    [self setupRefresh];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开启DDmemu左右滑动
    [self.appDelegate.DDMenu setEnableGesture:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //关闭DDmenu左右滑动
    [self.appDelegate.DDMenu setEnableGesture:NO];
}

- (void)setupRefresh{
// 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)  
    [self.tableView headerBeginRefreshing];
    
    
     // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
//     设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉 刷新页面";
    self.tableView.headerReleaseToRefreshText = @"松开 加载更多数据";
    self.tableView.headerRefreshingText = @"微博助手正在帮你刷新中,不客气";
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"微博助手正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{//
    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData insertObject:MJRandomData atIndex:0];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self loadStatuses];
        [self.tableView reloadData];                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];    });
}

- (void)footerRereshing{//    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData addObject:MJRandomData];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];    });
}

- (void)bindAction:(UIBarButtonItem *)btn
{
    
    [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
        if (!error) {
            NSLog(@"Sign in successful: %@", account.user.screenName);
        }
        
    }];
    
    
    [self loadStatuses];
    
    
    
}
- (void)signoutAction:(UIBarButtonItem *)btn
{
    Weibo *weibo = [[Weibo alloc] initWithAppKey:kAppKey withAppSecret:kAppSecret withRedirectURI:kRedirectURI];
    [weibo signOut];
//    if (weibo.isAuthenticated) {
//        NSLog(@"current user: %@", weibo.currentAccount.user.name);
//    }else{
//        NSLog(@"current user: %@", weibo.currentAccount.user.name);
//    }
    
    self.statuses = nil;
    [self.tableView reloadData];
//    MyHomeViewController *HVC = [[MyHomeViewController alloc]init];
//    [self.navigationController pushViewController:HVC animated:YES];

}

- (void)loadStatuses {
    [self dismissHUD];
//    [self showLoading:NO];
    self.statuses = nil;
    if (_query) {
        [_query cancel];
    }
    [self.tableView reloadData];

    _query = [[Weibo weibo] queryTimeline:StatusTimelineFriends count:50 completed:^(NSMutableArray *statuses, NSError *error) {
        if (error) {
            self.statuses = nil;
            NSLog(@"error:%@", error);
        }
        else {
            self.statuses = statuses;

            NSLog(@"%d",(int)self.statuses.count);
        }
        _query = nil;
        [_tableView reloadData];
    }];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    if (![Weibo.weibo isAuthenticated]) {
        
        [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
            if (!error) {
                NSLog(@"Sign in successful: %@", account.user.screenName);
                
            }
            else {
                NSLog(@"Failed to sign in: %@", error);
            }
        }];
    }
    else {
        [self loadStatuses];
    }

}
#pragma mark - UITableView delegate;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_query) { // loading...
        return 1;
    }
    if (!self.statuses) {
        return 1;
    }
    return _statuses.count;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"weiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //防止复用出错（maybe）
    cell = nil;
    if (!cell) {
      cell = [[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


//    if (_query) { // loading...
//        cell.textLabel.text = @"Loading...";
        
       
//    }
//    else if (!self.statuses) {
//        cell.textLabel.text = @"Failed to load...";
//    }
//    else {
    
        Status *weibo = [_statuses objectAtIndex:indexPath.row];
    
        cell.weiboModel = weibo;

//        cell.textLabel.text = weibo.text;
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
         Status *weibo = [self.statuses objectAtIndex:indexPath.row];
    CGFloat height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    

    height += 70;
    return height;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *weiboModel = [self.statuses objectAtIndex:indexPath.row];
    DetailViewController *DVC = [[DetailViewController alloc]init];
    DVC.weiboModel = weiboModel;
    
    [self.navigationController pushViewController:DVC animated:YES];
    
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
