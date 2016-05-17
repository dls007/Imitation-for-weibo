//
//  UserGridView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
//@class User;
@interface UserGridView : UIView
@property (nonatomic,retain)User *userModel;


@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickLebel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;



- (IBAction)buttonAction:(id)sender;

@end
