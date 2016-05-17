//
//  ThemeButton.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *highImageName;


@property(nonatomic,copy)NSString *backgroundImageName;
@property(nonatomic,copy)NSString *backgroundHighlightImageName;


-(id)initWithImage:(NSString *)imageName highlighted:(NSString *)highlightImageName;

- (id)initWithBackground:(NSString *)backgroundImageName highlightedBackground:(NSString *)highlightBackgroundImageName;


@end
