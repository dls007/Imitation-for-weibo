//
//  SearchViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/6.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "SearchViewController.h"
#import "NearWeiboViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"广场中心";
    
    for (int i = 100; i<=101; i++) {
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        btn.layer.shadowColor = [UIColor blackColor].CGColor;
        btn.layer.shadowOffset = CGSizeMake(3, 3);
        //透明度  默认透明
        btn.layer.shadowOpacity = 1;
        btn.layer.shadowRadius = 3;

    }
    
    
    
    
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

- (IBAction)nearWeiboAction:(id)sender {
    NearWeiboViewController *near = [[NearWeiboViewController alloc]init];
    [self.navigationController pushViewController:near animated:YES];
}

- (IBAction)nearUserAction:(id)sender {
}
@end
