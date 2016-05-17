//
//  WebViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/12.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *lImage = [UIImage imageNamed:@"left"];
    UIImage *rImage = [UIImage imageNamed:@"right"];
    UIImage *reImage = [UIImage imageNamed:@"refresh"];
    UIImage *pImage = [UIImage imageNamed:@"pop"];
    
    lImage = [lImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [_leftBtn setImage:lImage];
    
    rImage = [rImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_rightBtn setImage:rImage];
    
    reImage = [reImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_refreshBtn setImage:reImage];
    
    pImage = [pImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_popBtn setImage:pImage];
    
    
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    self.title = @"载入中...";
    [self.titleBar.topItem setTitle:self.title];
  
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(id)initWithURL:(NSString *)url {
    self = [super init];
    
    if (self != nil) {
        _url = url;

    }

    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.tabBarController.tabBar.hidden = YES;
}
#pragma mark -UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //通过document.title 可以拿到网页的title
    NSString *webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = webTitle;
        [self.titleBar.topItem setTitle:self.title];
}

- (IBAction)popAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backAction:(id)sender {
    //
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}
- (IBAction)pushAction:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
- (IBAction)refreshAction:(id)sender {
    [_webView reload];
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
