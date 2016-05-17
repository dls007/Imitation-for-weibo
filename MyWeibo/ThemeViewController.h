//
//  ThemeViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *themeTable;



@end
