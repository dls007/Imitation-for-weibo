//
//  SearchViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/6.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *nearWeiboBtn;

@property (weak, nonatomic) IBOutlet UIButton *nearUserBtn;

- (IBAction)nearWeiboAction:(id)sender;
- (IBAction)nearUserAction:(id)sender;

@end
