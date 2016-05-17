//
//  MyHomeViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/22.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@interface MyHomeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)headerRereshing;

@end
