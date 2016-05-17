//
//  RectButton.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/11.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "RectButton.h"

@implementation RectButton

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    
    
    //    [self setTitle:nil forState:UIControlStateNormal];
    
    if (_rectTitleLabel == nil) {
        _rectTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 70, 25)];
        _rectTitleLabel.backgroundColor = [UIColor clearColor];
        _rectTitleLabel.textColor = [UIColor blueColor];
        _rectTitleLabel.font = [UIFont systemFontOfSize:17.0f];
        _rectTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rectTitleLabel.text = _title;
        [self addSubview:_rectTitleLabel];
    }
    
}
-(void)setSubTitle:(NSString *)subTitle {
    if (_subTitle != subTitle) {
        _subTitle = subTitle;
    }
    
    
    [self setTitle:nil forState:UIControlStateNormal];
    
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -5, 70, 25)];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.textColor = [UIColor blackColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.text = _subTitle;
        [self addSubview:_subtitleLabel];
    }
}

@end
