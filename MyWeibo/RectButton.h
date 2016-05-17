//
//  RectButton.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RectButton : UIButton {

    UILabel *_rectTitleLabel;
    UILabel *_subtitleLabel;

}


@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subTitle;


@end
