//
//  FaceView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/20.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "FaceView.h"
#import "AnimatedGif.h"

#define item_width 60
#define item_height 55

@implementation FaceView

-(id)initWithFrame:(CGRect)frame{
 
    self = [super initWithFrame:frame];
    if (self) {
        [self initData:frame];
        self.backgroundColor = [UIColor whiteColor];
        self.pageNum = items.count;
    }
    return self;
}
/*
 行： row：4
 列： colum：7
 表情的尺寸：(30*30)
*/


/*
 items = [
 
 ["表情1"，“表情2”...“表情28”,],
 ["表情1"，“表情2”...“表情28”,]
         ];
 
 */
-(void)initData:(CGRect)frame {
    items = [[NSMutableArray alloc ]init];
    
    //整理表情，整理成一个二维数组
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *items2D = nil;
    for (int i = 0; i<fileArray.count;i ++) {
        NSDictionary *item = [fileArray objectAtIndex:i];
        if (i % 28 == 0) {
            items2D = [NSMutableArray arrayWithCapacity:28];
            [items addObject:items2D];
        }
        [items2D addObject:item];
    }
    
    //设置尺寸
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, items.count *414, 4*item_height);

    //放大镜
    preview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 72)];
    preview.image = [UIImage imageNamed:@"preview"];
    preview.hidden = YES;
    preview.backgroundColor = [UIColor clearColor];
    [self addSubview:preview];
    //放大镜中的表情
    UIImageView *faceItem = [[UIImageView alloc]initWithFrame:CGRectMake((64-35)/2,9, 35, 35)];
    faceItem.tag = 2016;
    faceItem.backgroundColor = [UIColor clearColor];
    [preview addSubview:faceItem];
}


/*
 items = [
 
            ["表情1"，“表情2”...“表情28”,],
            ["表情1"，“表情2”...“表情28”,]
 ];
 
 */
-(void)drawRect:(CGRect)rect {
    //定义行，列
    int row = 0,colum = 0;
    for (int i=0; i<items.count; i++) {
        NSArray *items2D = [items objectAtIndex:i  ];
        
        for (int j = 0; j < items2D.count; j++) {
            NSDictionary *item = [items2D objectAtIndex:j];
            
            NSString *imageName = [item objectForKey:@"png"];
            UIImage *image = [UIImage imageNamed:imageName];
            
            CGRect frame = CGRectMake(item_width*colum+13, item_height*row+10, 35, 35);
            
            //考虑页数，需要加上前几页的宽度
            float x = i *414 +frame.origin.x;
            frame.origin.x = x;

            
            [image drawInRect:frame];
            //更新列表
            colum ++;
            if (colum % 7 == 0) {
                row++;
                colum = 0;
            }
            if (row == 4) {
                row = 0;
            }
            
        }
        
    }

}

//touch事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    preview.hidden = NO;
    
    
    //touch对象
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
    
    //点击的时候禁用scrollView的移动
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView= (UIScrollView *)self.superview;
        scrollView.scrollEnabled = NO;
    }
    
   
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    preview.hidden = YES;
    //触摸停止scrollView允许移动
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView= (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
    UIImageView *faceItem = [preview viewWithTag:2016];
    UIImageView *locationAnimted = [faceItem viewWithTag:2017];
    
    
    if (self.block != nil) {
        _block(self.selectedFaceName);
    }
    
    
    [locationAnimted removeFromSuperview];
    
}


//计算触摸点的列和行
-(void)touchFace:(CGPoint)point {
    //页数
    int page = point.x /414 ;
    float x = point.x - (page *414)-13;
    float y = point.y-10;
    
    //计算列与行
    int colum = x / item_width;
    int row = y / item_height;
    
    //防止触摸超出范围  index越界
    if (colum > 6) {
        colum = 6;
    }
    if (colum < 0) {
        colum = 0;
    }
    if (row > 3) {
        row = 3;
    }
    if (row < 0) {
        row = 0;
    }
    
    //计算表情的索引
    int index = colum + (row * 7);
    
    NSArray *items2D = [items objectAtIndex:page];
    NSDictionary *item = [items2D objectAtIndex:index];
    NSString *faceName = [item objectForKey:@"chs"];
//    NSLog(@"%@",faceName);
    NSString *imageName = [item objectForKey:@"gif"];
    
//    NSURL *localUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    NSURL *localUrl =[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];

    UIImageView *localAnimation = [AnimatedGif getAnimationForGifAtUrl: localUrl];
    
    UIImageView *faceItem = [preview viewWithTag:2016];
    
      localAnimation.frame = CGRectMake((64-35)/2-10,5, 40, 40);
    localAnimation.tag = 2017;
//    faceItem = localAnimation;
    [faceItem addSubview:localAnimation];
    
    
//    UIImage *itemImage = [UIImage imageNamed:imageName];
    //将触摸位置的表情给放大镜中的imageView
//    UIImageView *faceItem = [preview viewWithTag:2016];
//    faceItem.image = itemImage;
    
    self.selectedFaceName = faceName;
   
   
    preview.frame = CGRectMake((page * 414)+colum * item_width, row *item_height-40, 64, 72);
  /*
   -------------------plist图片未完善 完善后使用以下优化方法----------------------
    //当触摸在同一表情范围的时候 不会不停更换图片
    if (![self.selectedFaceName isEqualToString:faceName] || self.selectedFaceName == nil) {
        
        NSString *imageName = [item objectForKey:@"gif"];
        UIImage *itemImage = [UIImage imageNamed:imageName];
        //将触摸位置的表情给放大镜中的imageView
        UIImageView *faceItem = [preview viewWithTag:2016];
        faceItem.image = itemImage;
        
        self.selectedFaceName = faceName;
   
   preview.frame = CGRectMake((page * 414)+colum * item_width, row *item_height-40, 64, 72);
    }
    */
}
//触摸移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    preview.hidden = NO;
    
    
    //touch对象
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
}
//触摸取消
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    preview.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView= (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
}
@end
