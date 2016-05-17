//
//  WeiboCell.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/23.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@class WeiboView;
@interface WeiboCell : UITableViewCell


@property (nonatomic,retain)UILabel *repostCountLable;  //转发数
@property (nonatomic,retain)UILabel *commentLable;     //回复数
@property (nonatomic,retain)UILabel *sourceLable;      //发布来源
@property (nonatomic,retain)UILabel *createLable;      //发布时间
@property (nonatomic,retain)UIImageView *userImage;    //用户头像视图

@property (nonatomic,retain)UILabel *nickLable;        //昵称
//微博数据模型对象
@property (nonatomic,retain)Status *weiboModel;
//微博视图
@property(nonatomic,retain)WeiboView *weiboView;


@end
