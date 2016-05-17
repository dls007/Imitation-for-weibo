//
//  FaceScrollView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/21.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"

@interface FaceScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView    *scrollView;
    FaceView        *myFaceView;
    UIPageControl   *pageController;
}



-(id)initWithSelectBlock:(SelectBlock)block;
@end
