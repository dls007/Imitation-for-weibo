//
//  MessageViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "MessageViewController.h"
#import "FaceView.h"
#import "FaceScrollView.h"
#import "UIFactory.h"
#import "DataService.h"
#import "Weibo.h"
#import "Status.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "DetailViewController.h"
#import "MJRefresh.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    
    [self loadAtWeiboData];

    
[self setupRefresh];
    

}
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_weiboTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [_weiboTableView headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_weiboTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
    //     设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _weiboTableView.headerPullToRefreshText = @"下拉 刷新页面";
    _weiboTableView.headerReleaseToRefreshText = @"松开 加载更多数据";
    _weiboTableView.headerRefreshingText = @"微博助手正在帮你刷新中,不客气";
    _weiboTableView.footerPullToRefreshText = @"上拉加载更多数据";
    _weiboTableView.footerReleaseToRefreshText = @"松开加载更多数据";
    _weiboTableView.footerRefreshingText = @"微博助手正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{//
    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData insertObject:MJRandomData atIndex:0];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格

        [_weiboTableView reloadData];                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_weiboTableView headerEndRefreshing];    });
}

- (void)footerRereshing{//    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData addObject:MJRandomData];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_weiboTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_weiboTableView footerEndRefreshing];    });
}


-(void)initViews {
    
    
    _weiboTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414, (736-20-44-49)) style:UITableViewStylePlain];
    _weiboTableView.delegate = self;
    _weiboTableView.dataSource = self;
    _weiboTableView.hidden = YES;
    [self.view addSubview:_weiboTableView];
    
    
    
NSArray *messageBtns = [NSArray arrayWithObjects:@"ATicon.png",
                        @"messageicon.png",
                        @"messagingicon.png",
                        @"systemmessages.png", nil];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    for (int i = 0; i<messageBtns.count; i++) {
        NSString *imageName = [messageBtns objectAtIndex:i];
        UIButton *button = [UIFactory createButton:imageName highlighted:imageName];
        button.showsTouchWhenHighlighted = YES;
        button.frame = CGRectMake(50 * i+10, 10, 30, 30);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [titleView addSubview:button];
    }
    self.navigationItem.titleView = titleView;
}


-(void)buttonAction:(UIButton *)btn {
    NSInteger tag = btn.tag;
    if (tag == 100) {
        
    }else if (tag == 101){
    
    }else if (tag == 102){
    
    }else if (tag == 103){
    
    }
}

-(void)loadAtWeiboData {
    
    [super showLoading:YES];
    
    [DataService requsetWithURL:@"statuses/mentions.json" params:nil httpMethod:@"GET" completeBlock:^(id result) {
        NSLog(@"%@",result);
        [self loadAtWeiboDataFinish:result];
    }];
}

-(void)loadAtWeiboDataFinish:(NSDictionary *)result {

    NSArray *statuses = [result objectForKey:@"statuses"];
    _weibos = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *statusesDic in statuses) {
        Status *weibo = [[Status alloc]initWithJsonDictionary:statusesDic];
        NSLog(@"%@",weibo.user.screenName);
        [_weibos addObject:weibo];
    }
    //刷新
        [super showLoading:NO];
    _weiboTableView.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_weibos) { // loading...
        return 1;
    }
   
    return _weibos.count;
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
    
    Status *weibo = [_weibos objectAtIndex:indexPath.row];
    
    cell.weiboModel = weibo;
    
    //        cell.textLabel.text = weibo.text;
    //    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *weibo = [_weibos objectAtIndex:indexPath.row];
    CGFloat height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    
    
    height += 70;
    return height;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *weiboModel = [_weibos objectAtIndex:indexPath.row];
    DetailViewController *DVC = [[DetailViewController alloc]init];
    DVC.weiboModel = weiboModel;
    
    [self.navigationController pushViewController:DVC animated:YES];
    
    //取消选中状态
    [_weiboTableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
