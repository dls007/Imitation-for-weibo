//
//  UIFactory.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory


+(ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc]initWithImage:imageName highlighted:highlightedName];
    return button;
}
+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)backgroundHighlightedName
{
    ThemeButton *button = [[ThemeButton alloc]initWithBackground:backgroundImageName highlightedBackground:backgroundHighlightedName];
    return button;
    
}


+(ThemeImageView *)createThemeImage:(NSString *)imageName{
    ThemeImageView *tImageView = [[ThemeImageView alloc]initWithImageName:imageName];
    return  tImageView;
}


+(ThemeLable *)createThemeLable:(NSString *)colorName{
    ThemeLable *tLable = [[ThemeLable alloc]initWithColorName:colorName];
    return tLable;
}

+(UIButton *)createNavigationButton:(CGRect)frame title:(NSString *)title {

    ThemeButton *button = [self createButtonWithBackground:@"xk.png" backgroundHighlighted:@"xk_on.png"];
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
  
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    return button;
}
@end
