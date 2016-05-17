//
//  DetailViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/5.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@class Status;
@class WeiboView;


@interface DetailViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
    WeiboView *_weiboView ;
}

@property (strong, nonatomic) IBOutlet UIView *userBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (nonatomic,retain)Status *weiboModel;

@end
