//
//  UserInfoView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectButton.h"
#import "User.h"

@interface UserInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *simpleDescription;
@property (weak, nonatomic) IBOutlet RectButton *followBtn;
@property (weak, nonatomic) IBOutlet RectButton *fansBtn;
@property (weak, nonatomic) IBOutlet RectButton *detailBtn;
@property (weak, nonatomic) IBOutlet RectButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (nonatomic,retain)User *user;

- (IBAction)followAction:(id)sender;



@end
