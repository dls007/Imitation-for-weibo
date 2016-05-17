//
//  UIUtils.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/30.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils




//获取documents下的文件路径
+ (NSString *)getDocumentsPath:(NSString *)fileName{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    return path;
}
//date 格式化为 string
+ (NSString *)stringFromFormat:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *str = [formatter stringFromDate:date];
    return str;
    
}
//string 格式化为 date
+ (NSDate *)dateFromFormat:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateString];
    return date;

}



//格式化这样的日期Tue May 31 17:46:55 +0800 2011
+ (NSString *)formatString:(NSString *)dateString{
    NSString *format = @"E M d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFormat:dateString format:format];
    
    NSString *text = [UIUtils stringFromFormat:createDate format:@"MM-dd HH:mm"];
    return text;
}

@end
