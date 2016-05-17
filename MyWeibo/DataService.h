//
//  DataService.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

//自定义ASI网络接口

typedef void(^RequsetFinishBlock) (id result);
@interface DataService : NSObject


+(ASIHTTPRequest *)requsetWithURL:(NSString *)urlString
                           params:(NSMutableDictionary *)params
                       httpMethod:(NSString *)httpMethod
                    completeBlock:(RequsetFinishBlock)block;
@end
