//
//  DataService.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "DataService.h"


#define BASE_URL @"https://open.weibo.cn/2/"
#define New_URL @"https://api.weibo.com/2/"

@implementation DataService



+(ASIHTTPRequest *)requsetWithURL:(NSString *)urlString
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                    completeBlock:(RequsetFinishBlock)block{

    //取得认证信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"AccessTokenKey"];
    
//不管是GET还是POST都拼接token
    urlString = [BASE_URL stringByAppendingFormat:@"%@?access_token=%@",urlString,accessToken];

    //处理GET请求参数
  
        NSComparisonResult comparRet1 =  [httpMethod caseInsensitiveCompare:@"GET"];
    if (comparRet1 == NSOrderedSame) {
        
        NSMutableString *paramsString = [NSMutableString string];
        
        NSArray *allkeys = [params allKeys];
        
        for (int i = 0; i<params.count; i++) {
            
            NSString *key = [allkeys objectAtIndex:i];
            id value = [params objectForKey:key];
            //拼接成get 样式
            [paramsString appendFormat:@"%@=%@",key,value];
            //倒数第二个参数后面
            if (i<params.count-1) {
                [paramsString appendFormat:@"&"];
            }
        }
        //post方法拼接参数
        if (paramsString.length>0) {
            urlString = [urlString stringByAppendingFormat:@"&%@",paramsString];
        }
        
    }
      NSURL *url = [NSURL URLWithString:urlString];
    __block ASIFormDataRequest *requset = [ASIFormDataRequest requestWithURL:url];
    //设置请求操作时间
    [requset setTimeOutSeconds:60];
    //设置请求方式
    [requset setRequestMethod:httpMethod];
   
    //处理POST请求方式
    NSComparisonResult comparRet2 =  [httpMethod caseInsensitiveCompare:@"POST"];
    
    if (comparRet2 == NSOrderedSame) {
        
        NSArray *allkeys = [params allKeys];
        
        for (int i = 0; i<params.count; i++) {
            
            NSString *key = [allkeys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            //判断是否文件上传
            if ([value isKindOfClass:[NSData class]]) {
                [requset addData:value forKey:key];
            }else {
                [requset addPostValue:value forKey:key];
            }
        }
    }
   //设置请求完成的Block
        [requset setCompletionBlock:^{
            NSData *data = requset.responseData;
            
            float version = [[[UIDevice currentDevice] systemVersion] floatValue];
            id result = nil;
            if (version >= 5.0)
                
            {
                //使用系统自带的nsjson
                 result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
            }else{
            //使用jsonkit
//                result = [data objectFormJSONData];
            }
            if (block != nil) {
                block(result);
            }
        }];
    //开启异步
    [requset startAsynchronous];
    
    return  nil;
}
    
@end
