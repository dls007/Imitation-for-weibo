//
//  FaceScrollView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/21.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "FaceScrollView.h"



@implementation FaceScrollView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews {
    myFaceView = [[FaceView alloc]initWithFrame:CGRectZero];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 414,4*55)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(myFaceView.frame.size.width, myFaceView.frame.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    //超出部分不裁剪
    scrollView.clipsToBounds = NO;
    scrollView.delegate = self;
    [scrollView addSubview:myFaceView];
    [self addSubview:scrollView];
    
    pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(-20, myFaceView.frame.size.height, 40, 20)];
    pageController.numberOfPages = myFaceView.pageNum;
    pageController.currentPage = 0;
    pageController.currentPageIndicatorTintColor =[UIColor blackColor];
    pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview: pageController];
    self.frame = CGRectMake(0, 470, scrollView.frame.size.width, 20+myFaceView.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView  {
    int pageNumber = _scrollView.contentOffset.x/414;
    pageController.currentPage = pageNumber;

}

-(id)initWithSelectBlock:(SelectBlock)block {
    self = [self initWithFrame:CGRectZero];
    if (self != nil) {
        myFaceView.block = block;
    }
    return self;

}
@end
