//
//  UIButton+webCatch.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/28.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UIButton+webCatch.h"

@implementation UIButton (webCatch)


- (void)setImagewithURL:(NSURL *)url {
    dispatch_queue_t queue = dispatch_queue_create("loadImage", NULL);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //设置placeHold图片
        UIImage *placeHold = [UIImage imageNamed:@"微博.png"];
        [self setImage:placeHold forState:UIControlStateNormal];
        
        //请求网络图片
        UIImage *image = [UIImage imageWithData:data];
        
       
        //使用原始图片
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        

        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //UI操作最好放主线程操作
            [self setImage:image forState:UIControlStateNormal];
            
            self.alpha = 0.0;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.alpha = 1.0;
            [UIView commitAnimations];
            
        });
        
    });
}

@end
