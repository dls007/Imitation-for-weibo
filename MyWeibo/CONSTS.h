//
//  CONSTS.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#ifndef CONSTS_h
#define CONSTS_h



#endif /* CONSTS_h */

//weibo oauth2.0
#define kAppRedirectURL @"http://api.weibo.com/oauth2/default.html"
#define kAppKey @"290554375"
#define kAppSecret @"f67b87a0b25be4e1daf7ab21318288b2"

#define URL_Upload @"statuses/upload.json"
#define URL_Friends @"friendships/friends.json"
#define URL_Followers @"friendships/followers.json"
//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a ];
#define kNavigationBarTitleLable @"kNavigationBarTitleLable"


#define kThemeName @"kThemeName"

//图片浏览模式
#define kBrowseMode @"kBrowseMode"
#define LargeBrowseMode 1 //大图浏览模式
#define SmallBrowseMode 2 //小图浏览模式
#define kReloadWeiboTableViewNotification @"kReloadWeiboTableViewNotification"