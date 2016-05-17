//
//  BaseNavigationController.m
//  WXMovie
//
//  Created by 周泉 on 13-5-21.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"
//#import "UIFactory.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

#pragma 通知
-(void)themeNotification:(NSNotification *)noitfication
{
    [self loadThemeImage];
}



- (void)loadThemeImage
{
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"nav_bg_all"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   //异步调用drawRect
    [self.navigationBar setNeedsDisplay];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    [self loadThemeImage];
    
    
    
    //添加手势
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipAction:)];
    
    swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGesture];
    
    
    
    
    
    
//    NSArray *viewControllers = self.viewControllers ;
//    if (viewControllers.count >1) {
//        UIButton *button = [UIFactory createButton:@"back.png" highlighted:@"back.png"];
//        button.frame = CGRectMake(0, 0, 24, 24);
//        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//        self.navigationItem.leftBarButtonItem = backItem;
//    }
}



- (void)swipAction:(UISwipeGestureRecognizer *)gesture {
    if (self.viewControllers.count > 1) {
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
            [self popViewControllerAnimated:YES];
        }
    }
    
    
}







//-(void)backAction
//{
//    [self popViewControllerAnimated:YES];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation UINavigationBar (customBackground)

- (void)drawRect:(CGRect)rect
{
    UIImage *img = [UIImage imageNamed:@"nav_bg_all"];
    [img drawInRect:rect];
}

@end
