//
//  FriendshipViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"



//typedef enum{
//    Attention,//关注列表
//    Fans  //粉丝列表
//} FriendshipsType;



typedef NS_ENUM(NSInteger, FriendshipsType) {
    Attention =100,//关注列表
    Fans  //粉丝列表
};


@interface FriendshipViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,assign)FriendshipsType *shipType;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) long long userId; //用户UID
@property (nonatomic,retain)NSMutableArray *data;

@property (nonatomic,copy)NSString *cursor;//游标值  记录最后请求的编号

@end
