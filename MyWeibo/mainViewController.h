//
//  mainViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"

//#import "AppDelegate.h"

@interface mainViewController : UITabBarController<ItemViewDelegate>

{
@private
    UIImageView *_tabBarBG;
    UIImageView *_selectView;
}
@end
