//
//  SettingViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
