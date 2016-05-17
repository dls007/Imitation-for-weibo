//
//  WeiboAnnotationView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView {

    UIImageView *userImage;     //用户头像
    UIImageView *weiboImage;    //微博图片视图
    UILabel *textLabel;         //微博内容
    
}

@end
