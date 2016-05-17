//
//  MyBaseModel.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/2.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBaseModel : NSObject
- (id)initWithContent:(NSDictionary *)dataDic;
- (void)setAttributes:(NSDictionary *)dataDic;
@end
