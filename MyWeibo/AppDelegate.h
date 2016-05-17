//
//  AppDelegate.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weibo.h"
#import "DDMenuController.h"
#import "mainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)DDMenuController *DDMenu;
//@property (strong, nonatomic) NSString *wbtoken;
//@property (strong, nonatomic) NSString *wbRefreshToken;
//@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

