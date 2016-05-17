//
//  FriendshipViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "FriendshipViewController.h"
#import "DataService.h"
//#import "FriendshipCell.m"
#import "FriendshipsCell.h"
#import "User.h"
#import "MJRefresh.h"
#import "CONSTS.h"

@interface FriendshipViewController ()
{
    NSString * myPickUrl;
}
@end

@implementation FriendshipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    _data = [NSMutableArray array];
   
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    if (self.shipType == Fans) {
        self.title = @"粉丝列表";
        [self loadData:URL_Followers];
        myPickUrl = URL_Followers;
    }
    
    else if (self.shipType == Attention){
    self.title = @"关注列表";
        [self loadData:URL_Friends];
        myPickUrl = URL_Friends;
        
    }
    
}



-(void)loadData:(NSString *)url {
    
        if(!self.userId){
                NSLog(@"用户Id为空");
                return;
            }
        
        
        
            NSString *userIdString = [NSString stringWithFormat:@"%lld", _userId];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:userIdString forKey:@"uid"];
        
            //返回结果的游标，下一页返回值里的next_cursor，上一页的previous_cursor，默认值位0
            if (self.cursor.length>0) {
                [params setObject:self.cursor forKey:@"cursor"];
            }
        
            [DataService requsetWithURL:url params:params httpMethod:@"GET" completeBlock:^(id result) {
                [self loadFollorDataFinish:result];
            }];

}
////加载关注列表数据
//-(void)loadFollowData {
//    if(!self.userId){
//        NSLog(@"用户Id为空");
//        return;
//    }
//    
//   
//    
//    NSString *userIdString = [NSString stringWithFormat:@"%lld", _userId];
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:userIdString forKey:@"uid"];
//    
//    //返回结果的游标，下一页返回值里的next_cursor，上一页的previous_cursor，默认值位0
//    if (self.cursor.length>0) {
//        [params setObject:self.cursor forKey:@"cursor"];
//    }
//    
//    [DataService requsetWithURL:@"friendships/friends.json" params:params httpMethod:@"GET" completeBlock:^(id result) {
//        [self loadFollorDataFinish:result];
//    }];
//}

-(void)loadFollorDataFinish:(NSDictionary *)result {
    NSArray *usersArray = [result objectForKey:@"users"];
    
    /*[
     ["用户1","用户2","用户3"],
     ["用户4","用户5","用户6"],
     ["用户7","用户8","用户9"],
     ....
     ]
     */
    
    NSMutableArray *array2D = nil;
    for (int i = 0; i<usersArray.count; i++) {
        
        array2D = [self.data lastObject];
        //每三个分一行
        if (array2D.count ==3 || array2D == nil) {
            array2D = [NSMutableArray arrayWithCapacity:3];
            [self.data addObject:array2D];
           
        }
        
        NSDictionary *userDic = [usersArray objectAtIndex:i];
        User *userModel = [[User alloc]initWithJsonDictionary:userDic];
        [array2D addObject:userModel];
    }
// NSLog(@"%ld",self.data.count);
    [self.tableView reloadData];
    
    
    //记录下一页游标值
    self.cursor = [result objectForKey:@"next_curson"];
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
        [self loadData:myPickUrl];
        [self.tableView reloadData];                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];    });
}

- (void)footerRereshing{//    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData addObject:MJRandomData];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self loadData:myPickUrl];
//        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];    });
}




//返回某一行对应的数据

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0.用static修饰的局部变量只会初始化一次，结束时销毁
    static NSString *ID = @"friendships";
    //1.先去缓存池找对应标示的cell
    FriendshipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果缓存池没有对应的cell再创建新的cell
    cell = nil;
    if (cell == nil) {
        cell = [[FriendshipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //Selection风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *array = [self.data objectAtIndex:indexPath.row];
    cell.data = array;

    //3.0覆盖数据
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}


@end
