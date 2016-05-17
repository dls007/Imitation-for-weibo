//
//  WeiboModel.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/2.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"

@implementation WeiboModel


-(NSDictionary *)attributeMapDictionary {

    NSDictionary *mapAtt = @{
            @"createData":@"create_at",
            @"weiboId":@"id",
            @"text":@"text",
            @"source":@"source",
            @"favorited":@"favorited",
            @"thumbnailImage":@"thumbnail_pic",
            @"bmiddleImage":@"bmiddle_pic",
            @"originalImage":@"original_pic",
            @"geo":@"geo",
            @"repostsCount":@"reposts_count",
            @"commentsCount":@"comments_count"
        };
    
    return mapAtt;
}



-(void)setAttributes:(NSDictionary *)dataDic{
    //将字典数据根据映射关系 填充到当前对象的属性中
    [super setAttributes:dataDic];
    
   
    NSDictionary *retweetDic = [dataDic objectForKey:@"retweeted_status"];
    if (retweetDic != nil) {        
    WeiboModel *relWeibo = [[WeiboModel alloc]initWithContent:retweetDic];
    self.relWeibo = relWeibo;
    }
    
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
    UserModel *user = [[UserModel alloc]initWithContent:userDic];
    self.user = user;
    }

}


@end
