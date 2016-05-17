//
//  BaseTableView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/31.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseTableView.h"

#import "MJRefresh.h"


@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        
        
        [self _initView];
    }
    
    return  self;
}

//初始化子视图
- (void)_initView {
    [self setupRefresh];
    
    
}
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
    //     设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.headerPullToRefreshText = @"下拉可以刷新了";
    self.headerReleaseToRefreshText = @"松开马上刷新了";
    self.headerRefreshingText = @"微博助手正在帮你刷新中,不客气";
    self.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.footerRefreshingText = @"微博助手正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{//
    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData insertObject:MJRandomData atIndex:0];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self headerEndRefreshing];    });
}

- (void)footerRereshing{//    // 1.添加假数据//    for (int i = 0; i<5; i++) {//        [self.fakeData addObject:MJRandomData];//    }
    // 2.1秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self footerEndRefreshing];    });
}


    
    
//    [self setupRefresh];
    

@end
