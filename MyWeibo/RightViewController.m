//
//  RightViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "RightViewController.h"
#import "AppDelegate.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    UIImage *sentImage = [UIImage imageNamed:@"sent"];
    UIImage *locationImage = [UIImage imageNamed:@"location"];
    UIImage *photographImage = [UIImage imageNamed:@"photograph"];
    UIImage *iImage = [UIImage imageNamed:@"image"];
    
    sentImage = [sentImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    locationImage = [locationImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    photographImage = [photographImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    iImage = [iImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *sentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sentBtn setImage:sentImage forState:UIControlStateNormal];
    sentBtn.frame = CGRectMake(360, 100, 35, 35);
    [sentBtn addTarget:self action:@selector(sentAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *photographBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photographBtn setImage:photographImage forState:UIControlStateNormal];
    photographBtn.frame = CGRectMake(360, 150, 35, 35);
    [photographBtn addTarget:self action:@selector(photographAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageBtn setImage:iImage forState:UIControlStateNormal];
    imageBtn.frame = CGRectMake(360, 200, 35, 35);
    [imageBtn addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setImage:locationImage forState:UIControlStateNormal];
    locationBtn.frame = CGRectMake(360, 250, 35, 35);
    [locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:sentBtn];
    [self.view addSubview:photographBtn];
    [self.view addSubview:imageBtn];
    [self.view addSubview:locationBtn];
    
}
-(void)sentAction {
    SendViewController *sendCtrl = [[SendViewController alloc]init];
    UINavigationController *sendNav = [[UINavigationController alloc]initWithRootViewController:sendCtrl];

    //从ddmenun  present控制器 dismiss的时候才回返回到ddmemu  才会调用showRootView
    [self.appDelegate.DDMenu presentViewController:sendNav animated:YES completion:nil];
    

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.appDelegate.DDMenu showRootController:YES];
}
-(void)photographAction {
    
}
-(void)imageAction {

}
-(void)locationAction {

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
