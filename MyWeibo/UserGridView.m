//
//  UserGridView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UserGridView.h"
#import "UIButton+webCatch.h"
//#import "UserViewController.h"
#import "UIView+Addtions.h"
@implementation UserGridView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"UserGridView" owner:self options:nil]lastObject];
        view.backgroundColor = [UIColor clearColor];
//        view.layer.masksToBounds = YES;
        [self addSubview:view];
        self.userInteractionEnabled = YES;
        
        UIImage *backgroundImage = [UIImage imageNamed:@"gridViewBackground.png"];
        
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:backgroundImage];
        backgroundImageView.frame = view.frame;
        [self insertSubview:backgroundImageView atIndex:0];
        
    }
    
    return self;
}


- (IBAction)buttonAction:(id)sender {
    NSLog(@"%@",_userModel.profileImageUrl);
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    //昵称
    self.nickLebel.text = _userModel.screenName;
    
    //粉丝数
    long favL = (long)_userModel.followersCount ;
    NSString *fans = [NSString stringWithFormat:@"%ld",favL];
    if (favL >= 10000) {
        favL = favL/10000;
        fans = [NSString stringWithFormat:@"%ld万",favL];
    }
    self.fansLabel.text =[NSString stringWithFormat:@"%@位粉丝",fans];
    if(favL<=0){
        self.fansLabel.text = @"还未拥有粉丝";
    }
    
    //头像
    //用户头像url
    NSString *urlString = self.userModel.profileImageUrl;
    [self.imageBtn setTitle:@"" forState:UIControlStateNormal];
    [self.imageBtn setImagewithURL:[NSURL URLWithString:urlString]];
}
@end
