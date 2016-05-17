//
//  BaseViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"
#import "UIFactory.h"
#import "CONSTS.h"

#define ScreenHeight6 736
#define ScreenWidth6 414
@interface BaseViewController ()

@end

@implementation BaseViewController

{
    UIView *_loadView;
    UILabel *mylable;
    UIWindow *_tipWindow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isBackButton == NO) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.isBackButton = YES;
 
    
    NSArray *viewControllers = self.navigationController.viewControllers ;
    
    if (viewControllers.count >1 && self.isBackButton == YES) {
        UIButton *button = [UIFactory createButton:@"back.png" highlighted:@"back.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        //点击时显示高亮
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        self.navigationItem.leftBarButtonItem = backItem;
     
    }
  

    
}


-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    
    UILabel *titleLable = [UIFactory createThemeLable:kNavigationBarTitleLable];
    
    mylable = titleLable;
    
//    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
//    mylable.textColor = [UIColor blackColor];
    mylable.font = [UIFont systemFontOfSize:18.0f];
    mylable.backgroundColor = [UIColor clearColor];
    mylable.text = title;
    [mylable sizeToFit];
    
    self.navigationItem.titleView = mylable;

    
    
    
    
}


- (void)showLoading:(BOOL)show {
    if (_loadView == nil) {
        _loadView = [[UIView alloc]initWithFrame:CGRectMake(0,ScreenHeight6/2-80,ScreenWidth6, 20)];
    
    
    
    //loading视图
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView startAnimating];
    
    //正在加载的Label
    UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    loadLabel.backgroundColor = [UIColor clearColor];
    loadLabel.text = @"正在加载...";
    loadLabel.font = [UIFont systemFontOfSize:17.0];
    loadLabel.textColor = [UIColor blackColor];
    [loadLabel sizeToFit];
    
    loadLabel.frame = CGRectMake((414-loadLabel.frame.size.width)/2+20, 0, ScreenWidth6, 20);

    activityView.frame = CGRectMake((414-loadLabel.frame.size.width)/2-30, 0, ScreenWidth6, 20);

    [_loadView addSubview:loadLabel];
    [_loadView addSubview:activityView];
        }
    
//    [self.view addSubview:_loadView];
    if (show) {
        if (![_loadView superview]) {
            [self.view addSubview:_loadView];
        }
    }
//        else {
    if (show == NO) {
        [_loadView removeFromSuperview];

    }
   
    
}

- (AppDelegate *)appDelegate
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (void)showHUD {

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
 [SVProgressHUD showWithStatus:@"疯狂加载中..."];
}
- (void)showHUDWithNoMask {
    
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:@"疯狂加载中..."];
}
-(void)showErrorHUD{
    [SVProgressHUD showErrorWithStatus:@"笨蛋，有错啦~"];

}
- (void)dismissHUD {
  [SVProgressHUD dismiss];
}
- (void)showHUDComplete {
    [SVProgressHUD showSuccessWithStatus:@"发布成功!~"];
}

static float progress = 0.0f;
- (void)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD showProgress:0 status:@"正在发布.."];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    progress += 0.1f;
    [SVProgressHUD showProgress:progress status:@"正在发布.."];
    
    if(progress < 1.0f){
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    } else {
        [SVProgressHUD showProgress:progress status:@"Success!"];
//        [self dismissHUD];
        [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:0.4f];
    }
}

//状态栏上的提示
-(void)showStatusTip:(BOOL)show title:(NSString *)title {
    if (_tipWindow == nil) {
        _tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, 414, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 414, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 2016;
        [_tipWindow addSubview:label];
        
        UIImageView *progressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"callBg@2x"]];
        progressImage.frame = CGRectMake(0, 16, 100, 4);
        progressImage.tag = 2017;
        [_tipWindow addSubview:progressImage];
        
    }
    
    UILabel *tipLabel = (UILabel *)[_tipWindow viewWithTag:2016];
    UIImageView *progress = (UIImageView *)[_tipWindow viewWithTag:2017];
    
    if (show) {
        tipLabel.text = title;
//        CGPoint point = CGPointMake(414, 16);
//        [self translationAnim:point uiimageView:progress];

        //不能使用makeKeyAndVisible 会夺走主窗口的权力
//        [_tipWindow makeKeyAndVisible];
        
        
        _tipWindow.hidden = NO;
        
        
    }else{
    
         _tipWindow.hidden = NO;
         CGPoint point = CGPointMake(414, 16);
        [self translationAnim:point uiimageView:progress];
        tipLabel.text = title;
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:3.8f];
    }
}
-(void)translationAnim:(CGPoint)location uiimageView:(UIImageView *)uiimageView
{
    // 步骤
    // 1. 创建基本动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 2. 设置基本动画属性
    // 2.1 设置动画时长
    [animation setDuration:3.0];
    
    // 起始点使用视图当前位置，可以不用设置
    // 2.2 设置目标点
    [animation setToValue:[NSValue valueWithCGPoint:location]];
    [animation setRepeatCount:2];
    // 设置填充模式，并关闭动画结束后移除属性
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    // 8. 设置动画速度控制函数
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    // 10. 设置动画Value储存信息（类似tag），以便在animationDidStop判断执行的动画方法
    [animation setValue:@"translation"forKey:@"animationType"];
    [animation setValue:[NSValue valueWithCGPoint:location] forKey:@"position"];
    // 7. 设置动画代理
    [animation setDelegate:self];
    // 3. 将动画添加到视图的图层
    [uiimageView.layer addAnimation:animation forKey:nil];
    // 9. 解决视图移动的目标点问题（需要等动画完成之后再进行）
    //        [uiiv setCenter:location];
}

-(void)removeTipWindow{

_tipWindow.hidden = YES;
    _tipWindow = nil;
}

@end
