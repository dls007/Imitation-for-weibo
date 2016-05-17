//
//  UserViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UserViewController.h"
#import "UserInfoView.h"
#import "Weibo.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "UIFactory.h"

@interface UserViewController ()

@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation UserViewController
{
    WeiboRequestOperation *_query;
    NSMutableArray *_requests;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    UserInfoView *userInfoView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, 414, 200)];
    userInfoView.user = self.weiboModel.user;
    self.tableView.tableHeaderView  = userInfoView;
    [self loadStatuses];
    
    UIButton *homeBtn = [UIFactory createButtonWithBackground:@"down_arrow.png" backgroundHighlighted:@"down_arrow.png"];
    
    homeBtn.frame = CGRectMake(0, 0, 40, 40);
    [homeBtn addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *homeItem = [[UIBarButtonItem alloc]initWithCustomView:homeBtn];
    self.navigationItem.rightBarButtonItem = homeItem;
    
}
-(void)goHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadStatuses {
    [self dismissHUD];
    //    [self showLoading:NO];
    self.statuses = nil;
    if (_query) {
        [_query cancel];
    }
//    [_tableView reloadData];
    


    
    _query = [Weibo.weibo queryTimeline:StatusTimelineUser count:50 completed:^(NSMutableArray *statuses, NSError *error) {
        if (error) {
            self.statuses = nil;
            NSLog(@"error:%@", error);
        }
        else {
            
            self.statuses = statuses;
            
            NSLog(@"%d",(int)self.statuses.count);
        }
        [_requests addObject:_query];
        _query = nil;
        [_tableView reloadData];
    }];
    
}

//在页面消失的时候取消网络请求 
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (WeiboRequestOperation *query in _requests) {
        [query cancel];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _statuses.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    if (_query) { // loading...
//        cell.textLabel.text = @"Loading...";
//    }
//    else if (!self.statuses) {
//        cell.textLabel.text = @"Failed to load...";
//    }
////    else {
//        Status *status = [_statuses objectAtIndex:indexPath.row];
//        cell.textLabel.text = status.text;
//        NSLog(@"%@",status.text);
////    }
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
@end
