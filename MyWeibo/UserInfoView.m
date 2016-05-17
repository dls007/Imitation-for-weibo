//
//  UserInfoView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UserInfoView.h"
#import "UIImageView+webCatch.h"
#import "FriendshipViewController.h"
#import "UIView+Addtions.h"

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil]lastObject];
        [self addSubview:view];
       
    }
    
    return self;
}



- (void)layoutSubviews {

    [super layoutSubviews];
    
    //头像图片
    NSString *imageString = _user.profileLargeImageUrl;
    [_userImage setImagewithURL:[NSURL URLWithString:imageString]];
    
    //昵称
    _nickName.text = _user.screenName;
    
    //性别
    Gender gender =  _user.gender;
    NSString *sexName = @"未知";
    if (gender == GenderUnknow) {
        sexName = @"未知";
    }else if (gender == GenderMale){
    
    sexName = @"男";
    }else if (gender == GenderFemale) {
    sexName = @"女";
    }
    //地址
    NSString *address = _user.location;
    if (address == nil) {
        address = @"";
    }
    _location.text = [NSString stringWithFormat:@"%@    %@",sexName,address];
    
    //简介
   
    _simpleDescription.text = (_user.userDescription == nil?@"":_user.userDescription);
    
    
    //微博数
     int count = _user.statusesCount;
    _countLable.text = [NSString stringWithFormat:@"共 %d 条微博",count];
    
    //粉丝数
    long favL = (long)_user.followersCount ;
    NSString *fans = [NSString stringWithFormat:@"%ld",favL];
    if (favL >= 10000) {
        favL = favL/10000;
        fans = [NSString stringWithFormat:@"%ld万",favL];
    }
    _fansBtn.title = @"粉丝";
    _fansBtn.subTitle = fans;
    
    //关注数
    _followBtn.title = @"关注";
    _followBtn.subTitle = [NSString stringWithFormat:@"%d",_user.friendsCount ];
 
    
}
- (IBAction)followAction:(id)sender {

    FriendshipViewController *friendshipCtrl = [[FriendshipViewController alloc]init];
    friendshipCtrl.userId = _user.userId;
    friendshipCtrl.shipType = Attention;
    [self.viewController.navigationController pushViewController:friendshipCtrl animated:YES];
    
}
- (IBAction)fansAction:(id)sender {
    FriendshipViewController *friendshipCtrl = [[FriendshipViewController alloc]init];
    friendshipCtrl.userId = _user.userId;
    friendshipCtrl.shipType = Fans;
    [self.viewController.navigationController pushViewController:friendshipCtrl animated:YES];
}

@end
