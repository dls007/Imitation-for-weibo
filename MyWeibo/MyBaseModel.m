//
//  MyBaseModel.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/2.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "MyBaseModel.h"

@implementation MyBaseModel


- (id)initWithContent:(NSDictionary *)dataDic
{
    self = [self init];
    
    if (self) {
        
        [self setAttributes:dataDic];
    }
    
    return self;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    // 建立映射关系
    NSDictionary *mapDic = [self mapAttributes];
    
    for (id key in mapDic) {
        
        // setter 方法
        SEL sel = [self setterMethod:key];
        
        if ([self respondsToSelector:sel]) {
            
            // 得到JSON key
            id jsonKey = [mapDic objectForKey:key];
            
            // 得到JSON value
            id jsonValue = [dataDic objectForKey:jsonKey];
            
            // [self setTitle:@"title"];
            // [self setDic:dic];
            [self performSelector:sel withObject:jsonValue];
            
        }
    }
} // 属性赋值
- (id)mapAttributes
{
    return nil;
}
- (SEL)setterMethod:(NSString *)key
{
    // 生成setter方法
    NSString *first = [[key substringToIndex:1] uppercaseString];
    NSString *end = [key substringFromIndex:1];
    NSString *setterName = [NSString stringWithFormat:@"set%@%@:", first, end];
    return NSSelectorFromString(setterName);
} // 生成setter方法
@end
