//
//  UIFactory.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLable.h"

@interface UIFactory : NSObject



+(ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)backgroundHighlightedName;
+(ThemeImageView *)createThemeImage:(NSString *)imageName;
+(ThemeLable *)createThemeLable:(NSString *)colorName;
//创建导航栏上的按钮
+(UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title ;
@end
