//
//  WeiboView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/23.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@class ThemeImageView;
@class TTTAttributeLabelView;
#define kweibo_width_List (414-70)  //微博在列表中的宽度
#define kweibo_width_Detial (394)   //微博在详情页面的宽度
@interface WeiboView : UIView




@property (nonatomic,retain)UILabel *textLable;                     //微博内容
@property (nonatomic,retain)UIImageView *image;                    //微博图片
@property (nonatomic,retain)ThemeImageView *repostBackgroundView;     //转发微博的背景视图
@property (nonatomic,retain)WeiboView *repostView;                 //转发的微博视图
@property (nonatomic,assign)CGFloat textHeight;
//微博模型对象
@property (nonatomic,retain)Status *weiboModel;

@property (nonatomic, strong) TTTAttributeLabelView  *attributeLabelView;

//当前的微博视图 是否为转发的微博视图
@property (nonatomic,assign)BOOL isRepost;

//当前微博是否现实在详细页面
@property(nonatomic,assign)BOOL isDetail;

//获取weiboView的高度
+ (CGFloat)getWeiboViewHeight:(Status *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetail;

//获取字体的大小
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost ;
@end
