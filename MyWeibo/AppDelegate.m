//
//  AppDelegate.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "AppDelegate.h"


#import "LeftViewController.h"
#import "RightViewController.h"
#import "CONSTS.h"
#import "ViewController.h"
#import "ThemeManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置之前使用的主题
    [self setTheme];
    
    mainViewController *mVC = [[mainViewController alloc] init];
    
    _DDMenu = [[DDMenuController alloc]initWithRootViewController:mVC];
    LeftViewController *LVC = [[LeftViewController alloc]init];
    RightViewController *RVC = [[RightViewController alloc]init];
    _DDMenu.leftViewController = LVC;
    
    
    _DDMenu.rightViewController = RVC;
    
    self.window.rootViewController = _DDMenu;
    
    
    
    //weibo相关
    Weibo *weibo = [[Weibo alloc] initWithAppKey:kAppKey withAppSecret:kAppSecret withRedirectURI:kRedirectURI];
//    [Weibo setWeibo:weibo];
//        [weibo signOut];
    // Override point for customization after application launch.
    
    if (weibo.isAuthenticated) {
        NSLog(@"current user: %@", weibo.currentAccount.user.name);
//        NSLog(@"%@",weibo.currentAccount.accessToken);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:weibo.currentAccount.accessToken  forKey:@"AccessTokenKey"];
        [defaults setObject:weibo.currentAccount.userId forKey:@"uid"];
        /*
         [weibo newStatus:@"test weibo" pic:nil completed:^(Status *status, NSError *error) {
         if (error) {
         NSLog(@"failed to post:%@", error);
         }
         else {
         NSLog(@"success: %lld.%@", status.statusId, status.text);
         }
         }];
         
         NSData *img = UIImagePNGRepresentation([UIImage imageNamed:@"Icon"]);
         [weibo newStatus:@"test weibo with image" pic:img completed:^(Status *status, NSError *error) {
         if (error) {
         NSLog(@"failed to upload:%@", error);
         }
         else {
         StatusImage *statusImage = [status.images objectAtIndex:0];
         NSLog(@"success: %lld.%@.%@", status.statusId, status.text, statusImage.originalImageUrl);
         }
         }];
         */
        
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setTheme{
    NSString *themeName = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    [[ThemeManager shareInstance]setThemeName:themeName];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
//{
//    
//}

//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"发送结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
//        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
//        if (accessToken)
//        {
//            self.wbtoken = accessToken;
//        }
//        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
//        if (userID) {
//            self.wbCurrentUserID = userID;
//        }
//        [alert show];
//    }
//    else if ([response isKindOfClass:WBAuthorizeResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"认证结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
//        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
//        [alert show];
//    }
//    else if ([response isKindOfClass:WBPaymentResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"支付结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"邀请结果", nil);
//        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }else if([response isKindOfClass:WBShareMessageToContactResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"发送结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
//        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
//        if (accessToken)
//        {
//            self.wbtoken = accessToken;
//        }
//        NSString* userID = [shareMessageToContactResponse.authResponse userID];
//        if (userID) {
//            self.wbCurrentUserID = userID;
//        }
//        [alert show];
//    }
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
@end
