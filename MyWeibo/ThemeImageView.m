//
//  ThemeImageView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

- (id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}


- (id)init
{
   self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

-(void)loadThemeImage{
    if (self.imageName == nil) {
        return ;
    }else{
        
        ThemeManager *themeManager = [ThemeManager shareInstance];
        
        UIImage *image = [themeManager getThemeImage:_imageName];
        
//        image = [image stretchableImageWithLeftCapWidth:*(self.leftCapWidth) topCapHeight:*(self.topCapHeight)];
        [self setImage:image];
    }
}
//复写set方法   必要 重要！！
- (void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
    
}

#pragma  mark 通知
-(void)themeNotification:(NSNotification *)notification {
    [self loadThemeImage];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
@end
