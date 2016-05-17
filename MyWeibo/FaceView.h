//
//  FaceView.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/20.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock)(NSString *faceName);

@interface FaceView : UIView

{
@private NSMutableArray *items;
@private UIImageView *preview;

    
}
@property (nonatomic,copy)NSString *selectedFaceName;
@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,copy)SelectBlock block;


@end
