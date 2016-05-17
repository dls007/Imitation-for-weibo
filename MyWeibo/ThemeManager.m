//
//  ThemeManeger.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "ThemeManager.h"
#import "CONSTS.h"



static ThemeManager *sigleton = nil;

@implementation ThemeManager



+(ThemeManager *)shareInstance{
    if (sigleton == nil) {
        //同步锁
        @synchronized(self) {
            sigleton = [[ThemeManager alloc]init];
        }
    }
    return sigleton;
}

- (id)init {
    self = [super init];
    if (self) {
      NSString *path = [[NSBundle mainBundle]pathForResource:@"Theme" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:path];
        //初始化为空 使用默认图片 supportingFiles中的图片
        self.themeName = nil;
    }
    return self;
}
//获取主题目录
- (NSString *)getThemePath{
    if (self.themeName == nil) {
        //获取bundle的根路径
        NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
        return resourcePath;
    }
        //取得主题路径 如: themeImage/brown
        NSString *themePath = [self.themesPlist objectForKey:_themeName];
        //程序包根路径
        NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
        //完整路径
        NSString *path = [resourcePath stringByAppendingPathComponent:themePath];
        return path;
    
}

// 返回当前主题下，图片名对应的图片
- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    //获取主题目录
    NSString *themePath = [self getThemePath];
    //imageName 在当前主题的目录
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return  image;

}

//获取主题对应的字体颜色
- (UIColor *)getColorWithName:(NSString *)name{
    if (name.length == 0) {
        return nil;
    }
    //返回三色值
   NSString *rgb =  [_fontColorPlist objectForKey:name];
    //用逗号分开
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count == 3) {
           float r = [rgbs[0] floatValue];
           float g = [rgbs[1] floatValue];
           float b = [rgbs[2] floatValue];
        UIColor *color = Color(r, g, b, 1);
//        NSLog(@"%f,%f,%f",r,g,b);
         return color;
    }

    return nil;
}

//切换主题时 会调用此方法设置主题名称
-(void)setThemeName:(NSString *)themeName
{
    
    if (_themeName != themeName) {
        _themeName = [themeName copy];
    }
    
    //获取主题目录
    NSString *themeDir = [self getThemePath];
    //获取主题目录下的fontColor.plist
    NSString *path = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:path];
    
//    NSLog(@"%@",path);
    
}


#pragma mark - sigleton setting

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone{
    return self;
}

//- (id)retain{
//    return self;
//}

//- (unsigned)retainCount{
//    return UINT_MAX;
//}




@end
