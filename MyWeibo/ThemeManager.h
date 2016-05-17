//
//  ThemeManeger.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

@interface ThemeManager : NSObject
//当前使用的主题名称
@property (nonatomic,retain)NSString *themeName;
//plist文件读取到该字典
@property (nonatomic,retain)NSDictionary *themesPlist;
@property(nonatomic,retain)NSDictionary *fontColorPlist;


// 主题管理类  设计成单例
+ (ThemeManager *)shareInstance;

// 返回当前主题下，图片名对应的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//返回颜色
- (UIColor *)getColorWithName:(NSString *)name;





@end
