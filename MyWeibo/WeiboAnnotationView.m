//
//  WeiboAnnotationView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "NearbyWeiboAnnotation.h"
#import "UIImageView+webCatch.h"

@implementation WeiboAnnotationView

-(void)initViews {
    userImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    userImage.layer.borderWidth = 1;
    
    
    weiboImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//    weiboImage.contentMode = UIViewContentModeScaleAspectFit;
    weiboImage.backgroundColor = [UIColor blackColor];
    
    textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:12.0];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 3;
    
    [self addSubview:weiboImage];
    [self addSubview:textLabel];
    //头像放最上面
    [self addSubview:userImage];
    
}

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self initViews];
    }
    return  self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
   
    
    //                   指针                      对象
    NearbyWeiboAnnotation *weiboAnnotation = self.annotation;
    
    Status *weibo = nil;
    
    //判断weiboAnnotation是否真的是NearbyWeiboAnnotation类  （确保真是自定义的类 调用方法时不会发生崩溃）
    if ([weiboAnnotation isKindOfClass:[NearbyWeiboAnnotation class]]) {
        weibo = weiboAnnotation.weiboModel;
    }
    
    NSString *thumbnailImage = weibo.thumbnailImageUrl;
    if (thumbnailImage.length>0) {
        self.image = [UIImage imageNamed:@"nearby_Bg2.png"];
        
        //加载微博图片
        weiboImage.frame = CGRectMake(15, 15, 90, 85);
        [weiboImage setImagewithURL:[NSURL URLWithString:thumbnailImage]];
        
        //加载用户头像
        userImage.frame = CGRectMake(70, 70, 30, 30);
        NSString *userUrl = weibo.user.profileImageUrl;
        [userImage setImagewithURL:[NSURL URLWithString:userUrl]];
        
        textLabel.hidden = YES;
        weiboImage.hidden = NO;
    }else{
    //不带微博视图
        //加载用户头像
        userImage.frame = CGRectMake(20, 20, 45, 45);
        NSString *userUrl = weibo.user.profileImageUrl;
        [userImage setImagewithURL:[NSURL URLWithString:userUrl]];
        
        //微博内容
        textLabel.frame = CGRectMake(70, 20, 110, 45);
        textLabel.text = weibo.text;
        textLabel.hidden = NO;
        weiboImage.hidden = YES;
        
        self.image = [UIImage imageNamed:@"nearby_Bg1.png"];
    }


    
}
@end
