//
//  UIImageView+webCatch.m
//  webCatch
//
//  Created by DLS-MACMini on 16/1/27.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "UIImageView+webCatch.h"

@implementation UIImageView (webCatch)


- (void)setImagewithURL:(NSURL *)url {
    dispatch_queue_t queue = dispatch_queue_create("loadImage", NULL);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //UI操作最好放主线程操作
            self.image = image;
        });
     
    });
}
@end
