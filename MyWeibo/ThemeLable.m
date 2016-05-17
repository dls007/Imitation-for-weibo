//
//  ThemeLable.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/2.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "ThemeLable.h"
#import "ThemeManager.h"

@implementation ThemeLable



- (id)init
{
    self = [super init];
    if (self != nil) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (id)initWithColorName:(NSString *)colorNmae{
   
  
    
    self = [self init];
    if (self != nil) {
        self.colorName = colorNmae;
    }
    return self;
}
//复写setColorName
-(void)setColorName:(NSString *)colorName
{
    if (_colorName != colorName) {
        _colorName = [colorName copy];
    }
    [self setColor];

}

-(void)setColor{
    
    UIColor *textColor = [[ThemeManager shareInstance]getColorWithName:_colorName];
    self.textColor = textColor;
       
}

#pragma  mark 通知
-(void)themeNotification:(NSNotification *)notification
{
    [self setColor];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
