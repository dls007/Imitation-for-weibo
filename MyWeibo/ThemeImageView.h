//
//  ThemeImageView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic,copy)NSString *imageName;
//@property(nonatomic,assign)NSInteger *leftCapWidth;
//@property(nonatomic,assign)NSInteger *topCapHeight;

- (id)initWithImageName:(NSString *)imageName;


@end
