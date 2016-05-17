//
//  ThemeButton.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton


-(id)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightImageName
{
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highImageName = highlightImageName;
        
    }
    return self;
}

- (id)initWithBackground:(NSString *)backgroundImageName
   highlightedBackground:(NSString *)highlightBackgroundImageName
{
    self = [self init];
    if (self) {
        self.backgroundImageName = backgroundImageName;
        self.backgroundHighlightImageName = highlightBackgroundImageName;
    }
    return self;
}
//初始化时注册监听通知
- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return  self;
}

-(void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
  
}



- (void)loadThemeImage{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
    UIImage *image = [themeManager getThemeImage:_imageName];
    UIImage *highlightImage = [themeManager getThemeImage:_highImageName];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlightImage forState:UIControlStateHighlighted];
    
    
    UIImage *backgroundImage = [themeManager getThemeImage:_backgroundImageName];
    UIImage *highlightedBackgroundImage = [themeManager getThemeImage:_backgroundHighlightImageName];
    
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

#pragma  mark  -  复写set方法 ！！！
- (void)setImageName:(NSString *)imageName
{
    if (_imageName !=imageName) {
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
    
}

- (void)setHighImageName:(NSString *)highImageName
{
    if (_highImageName != highImageName) {
        _highImageName = [highImageName copy];
    }
    [self loadThemeImage];
    
}
-(void) setBackgroundImageName:(NSString *)backgroundImageName
{
    if (_backgroundImageName != backgroundImageName) {
        _backgroundImageName = [backgroundImageName copy];
    }
    [self loadThemeImage];
}
-(void) setBackgroundHighlightImageName:(NSString *)backgroundHighlightImageName
{
    if (_backgroundHighlightImageName != backgroundHighlightImageName) {
        _backgroundHighlightImageName = [backgroundHighlightImageName copy];
    }
    [self loadThemeImage];
}

@end
