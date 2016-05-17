//
//  BaseViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@class AppDelegate;

@interface BaseViewController : UIViewController

@property (nonatomic,assign)BOOL isBackButton;
//@property (nonatomic,retain)UIView *loadView;


- (void)showLoading:(BOOL)show;
- (void)showHUD;
- (void)dismissHUD;
- (void)showHUDComplete;
- (void)showWithProgress:(id)sender;
-(void)showErrorHUD;
- (void)showHUDWithNoMask;

-(void)showStatusTip:(BOOL)show title:(NSString *)title;
-(void)removeTipWindow;

- (AppDelegate *)appDelegate;
@end
