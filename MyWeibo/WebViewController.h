//
//  WebViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/12.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
@property(nonatomic,copy) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *popBtn;
@property (weak, nonatomic) IBOutlet UINavigationBar *titleBar;



-(id)initWithURL:(NSString *)url;
@end
