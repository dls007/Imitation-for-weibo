//
//  SendViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/13.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    NSMutableArray *_buttons;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *editorBar;

@property (nonatomic,copy)NSString *longtitude_b;    //block中是使用
@property (nonatomic,copy)NSString *latitude_b;

@property (weak, nonatomic) IBOutlet UIView *placeView;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *placeBackgroundView;

@property (nonatomic,copy)UIImage *sendImage;

@property (nonatomic,retain) UIButton *sendImageBtn;
@property (nonatomic,retain)UIImageView *fullImageView;

@property (nonatomic,retain)FaceScrollView *faceView;//表情视图
@property(nonatomic,assign)BOOL isRepeatUseSth;
@end
