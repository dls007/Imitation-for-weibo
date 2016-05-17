//
//  UIView+Addtions.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/6.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UIView+Addtions.h"

@implementation UIView (Addtions)


- (UIViewController *)viewController {

    //拿到下一个响应者
   UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }while (next != nil) ;
    
    return (UIViewController *)next;
}

@end
