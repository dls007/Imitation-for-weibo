//
//  ItemView.m
//  WXMovie
//
//  Created by 周泉 on 13-5-22.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "ItemView.h"
#import "UIFactory.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
        [self addGesture];
    }
    return self;
}

- (void)initSubviews
{
    // 小按钮
    _itemBtn = [[ThemeButton alloc] init];
//    _itemBtn = [UIFactory createButton:<#(NSString *)#> highlighted:<#(NSString *)#>]
     _itemBtn.frame = CGRectMake(20, 5, 40, 40);
    _itemBtn.contentMode = UIViewContentModeScaleAspectFit;

//    _itemBtn.userInteractionEnabled = NO;
    [self addSubview:_itemBtn];
    
    // 小标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(8, 46, 50, 10)];
    _title.backgroundColor = [UIColor clearColor];
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont boldSystemFontOfSize:10];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}

- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didItemView:)];
    [self addGestureRecognizer:tap];
    
}



#pragma mark - Target Actions
- (void)didItemView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didItemView:atIndex:)]) {
        
        [self.delegate didItemView:self atIndex:self.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
