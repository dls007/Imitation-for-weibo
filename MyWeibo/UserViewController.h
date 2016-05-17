//
//  UserViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"
#import "Status.h"
#import "User.h"
//#import "BaseTableView.h"

@interface UserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)Status *weiboModel;
@property (nonatomic,retain)User *userModel;
@end
