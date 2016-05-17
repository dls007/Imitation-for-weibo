//
//  UIUtils.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/30.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject


//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName;
//date 格式化为 string
+ (NSString *)stringFromFormat:(NSDate *)date format:(NSString *)format;
//string 格式化为 date
+ (NSDate *)dateFromFormat:(NSString *)dateString format:(NSString *)format;
//格式化这样的日期Tue May 31 17:46:55 +0800 2011
+ (NSString *)formatString:(NSString *)dateString;
@end
