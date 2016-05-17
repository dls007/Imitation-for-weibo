//
//  ThemeLable.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/2.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLable : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorNmae;
@end
