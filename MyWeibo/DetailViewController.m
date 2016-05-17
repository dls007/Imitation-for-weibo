//
//  DetailViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/5.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Status.h"
#import "UIImageView+webCatch.h"
#import "WeiboView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _initView];
}

//创建子视图
-(void)_initView {

    //直接设置好所有东西的高度  （把weiboView的高度也计算进去）
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 280)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    //填充数据
    NSString *userImageUrl = _weiboModel.user.profileImageUrl;
    [self.headImage setImagewithURL:[NSURL URLWithString:userImageUrl]];
    
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.borderColor = [UIColor brownColor].CGColor;
    self.headImage.layer.borderWidth = 1;
    self.headImage.layer.masksToBounds = YES;
    
      self.nickLabel.text = _weiboModel.user.screenName;
    
    [tableHeaderView addSubview:self.userBarView];
    
    

    
    
    
//-------------创建微博视图---------------
    CGFloat h = [WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isDetail:YES];
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(40,self.userBarView.bounds.size.height+10, 394, h)];
    
    _weiboView.image.frame = CGRectMake(50, 50, 200, 280);
    _weiboView.isDetail = YES;
    _weiboView.weiboModel = _weiboModel;
//    _weiboView.attributeLabelView
    [tableHeaderView addSubview:_weiboView];
    
    
    
    self.tableView.tableHeaderView = tableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
////    CGFloat h = [WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isDetail:YES];
////    h = h+60;
//
////    return 200;
//}

@end
