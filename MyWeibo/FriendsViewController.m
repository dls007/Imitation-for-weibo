//
//  FriendsViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendshipViewController.h"


@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friends";
    
        self.isBackButton = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _uid = [defaults objectForKey:@"uid"];
    FriendshipViewController *friendshipCtrl = [[FriendshipViewController alloc]init];
    friendshipCtrl.shipType = Attention;
    friendshipCtrl.userId = [_uid longLongValue];
    
    [self.navigationController pushViewController:friendshipCtrl animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
