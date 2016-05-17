//
//  SendViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/13.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "SendViewController.h"
#import "UIFactory.h"
#import "weibo.h"
#import "NearbyViewController.h"
#import "RegexKitLite.h"
#import "DataService.h"
#import "CONSTS.h"


@interface SendViewController ()

@end

@implementation SendViewController
{
    WeiboRequestOperation *_query;
    NSMutableArray *_data;
}

- (void)viewDidLoad {
    
    self.isBackButton = YES;

    
    [super viewDidLoad];
    _data = [NSMutableArray array];
    //键盘出现就添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    
    _buttons = [[NSMutableArray alloc]initWithCapacity:6];
    [self setTitle:@"发布新微博"];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor darkGrayColor]];
    
    CGRect frame = CGRectMake(0, 0, 40, 30);
    UIButton *button = [UIFactory createNavigationButton:frame title:@"取消"];
    [button addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem= cancleItem;
    
    UIButton *button2 = [UIFactory createNavigationButton:frame title:@"发布"];
    [button2 addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = sendItem;
    
    [self _initView];
    
}
-(void)keyboardShowNotification:(NSNotification *)notification{
    //object拿出来的是不能是rect 这种结构体
    NSValue *rectValue = [notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    //再将value转换成结构体rect
    CGRect keyboardRect = [rectValue CGRectValue];
    

    
    
    
    
    
    
   
}
-(void)cancleAction{
    NSLog(@"cancle");
    //取消通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)sendMessage {
    
    
    
    if (_textView.text.length == 0) {
        [self showErrorHUD];
    }else{
    //替换输入的[发呆]之类的表情代号成图片   替换成功  接口不兼容文字附件 暂不使用
//        [self replaceFaceImage];
        
        [self doSendData:_textView.text];
        [self showWithProgress:self];
        
        [super showStatusTip:NO title:@"发送中..."];
        
        [self performSelector:@selector(cancleAction) withObject:nil afterDelay:3.8f];
        
        
       
       
    }
    

}

-(void)replaceFaceImage {
    
    //加载plist文件中的数据
    NSBundle *bundle = [NSBundle mainBundle];
//    2.如何从.plist文件中获取数据呢？先通过bundle获取资源文件的路径，在通过文件路径创建数组，数组中存储的数据就是文件中的内容代码如下：
    //寻找资源的路径
    NSString *path = [bundle pathForResource:@"emoticons" ofType:@"plist"];
    
//    　3.生成我们的测试字符串，最后一个不是任何表情，不做替换。
    //获取plist中的数据
    NSArray *face = [[NSArray alloc] initWithContentsOfFile:path];
    
//    　4.把上面的str转换为可变的属性字符串，因为我们要用可变的属性字符串在TextView上显示我们的表情图片，转换代码如下：
    //将内容转换为可变字符串
NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:_textView.text];
    
//    5.进行正则匹配，获取每个表情在字符串中的范围，下面的正则表达式会匹配[,所以[123567]也会被匹配上，下面我们会做相应的处理
    //筛选出[]的内容
    NSString *str = _textView.text;
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    //通过正则表达式来匹配字符串
    NSArray *resultArray = [re matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    
    
//    6.数据准备工作完成，下面开始遍历资源文件找到文字对应的图片，找到后把图片名存入字典中，图片在源字符串中的位置也要存入到字典中，最后把字典存入可变数组中。代码如下
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        
        //获取原字符串中对应的值
        NSString *subStr = [str substringWithRange:range];
        
        for (int i = 0; i < face.count; i ++)
        {
            if ([face[i][@"chs"] isEqualToString:subStr])
            {
                
                //face[i][@"gif"]就是我们要加载的图片
                //新建文字附件来存放我们的图片
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                
                //给附件添加图片
                textAttachment.image = [UIImage imageNamed:face[i][@"png"]];
                
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                
                //把字典存入数组中
                [imageArray addObject:imageDic];
                
            }
        }
    }
    
//    7.转换完成，我们需要对attributeString进行替换，替换的时候要从后往前替换，弱从前往后替换，会造成range和图片要放的位置不匹配的问题。替换代码如下：
    //.从后往前替换
    for (int i = (int)imageArray.count -1; i >= 0; i--)
    {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
        
    }
//    　8.把替换好的可变属性字符串赋给TextView
    

    //把替换后的值赋给我们的TextView
    self.textView.attributedText = attributeString;
}




-(void)doSendData:(NSString *)contentData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.longtitude_b.length >0) {
        [params setObject:self.longtitude_b forKey:@"long"];
    }
    if (self.latitude_b.length >0) {
        [params setObject:self.latitude_b forKey:@"lat"];
    }
    
    
    if (self.sendImage == nil) {
        
        [[Weibo weibo]newStatus:contentData pic:nil params:params completed:^(Status *status, NSError *error) {
            if (error) {
                NSLog(@"failed to post:%@", error);
            }
            else {
                NSLog(@"success: %lld.%@", status.statusId, status.text);
            }
        }];
    }else{
        //将图片转换成NSData
        NSData *data = UIImageJPEGRepresentation(self.sendImage, 0.3);
//        [[Weibo weibo]newStatus:contentData pic:data params:params completed:^(Status *status, NSError *error) {
//            if (error) {
//                NSLog(@"failed to post:%@", error);
//            }
//            else {
//                NSLog(@"success: %lld.%@", status.statusId, status.text);
//            }
//        
//        }];
        
        //使用自定义接口
#pragma mark - 自定义接口
        [params setObject:contentData forKey:@"status"];
        
            [params setObject:data forKey:@"pic"];
        
        
        
    [DataService requsetWithURL:URL_Upload params:params httpMethod:@"post" completeBlock:^(id result) {
        
    }];
    }
    
}



//初始化子视图
-(void)_initView {
    
    //显示键盘
    [self.textView becomeFirstResponder];
    self.textView.delegate = self;
    
    NSArray *imageNames = [NSArray arrayWithObjects:@"location_n",@"photograph",@"image",@"topic",@"face",@"keyboard", nil];
    
    NSArray *hImageNames = [NSArray arrayWithObjects:@"location_h",@"photograph_h",@"image_h",@"topic_h",@"face_h",@"keyboard_h", nil];
    
    
    for (int i=0; i<imageNames.count; i++) {
        NSString *imageName = [imageNames objectAtIndex:i];
        NSString *hImageName = [hImageNames objectAtIndex:i];
        
        UIButton *button = [UIFactory createButton:imageName highlighted:hImageName];
        
        [button setImage:[UIImage imageNamed:hImageName] forState:UIControlStateSelected];
        
        button.tag = (10+i);
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(27+(80*i), 15, 35, 35);
        [self.editorBar addSubview:button];
        [_buttons addObject:button];
        
        if (i==5) {
            button.hidden = YES;
            button.frame = CGRectMake(27+(80*4), 15, 35, 35);
        }
        
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelPlaceView)];
    [_placeView addGestureRecognizer:tap];
    
}
-(void)cancelPlaceView{
    

    UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"是否删除当前位置" message:@"删除后再次点击定位按钮重新定位" preferredStyle:UIAlertControllerStyleActionSheet];
    
   
    UIAlertAction *uaa1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *uaa2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        _placeView.hidden = YES;
        UIButton *locationBtn = [_buttons objectAtIndex:0];
        locationBtn.selected = NO;
    }];
    
    [uac addAction:uaa1];
    [uac addAction:uaa2];

    
    [self presentViewController:uac animated:YES completion:nil];
    
    
}

//显示表情视图面板
-(void)showFaceView {
    [self.textView resignFirstResponder];

    
    if (_faceView == nil) {
        //block中self容易引起循环饮用 用__block修饰
        __block SendViewController *this = self;
        _faceView = [[FaceScrollView alloc]initWithSelectBlock:^(NSString *faceName) {
            //将选择的表情以字符加到textView
            NSString *text = this.textView.text;
            text = [text stringByAppendingString:faceName];
            this.textView.text = text;
        }];
        
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, 736-44-20);
        
        [self.view addSubview:_faceView];
        
    }
    _faceView.hidden =NO;
    
    UIButton *faceBtn = [_buttons objectAtIndex:4];
    UIButton *keyboard = [_buttons objectAtIndex:5];
    keyboard.hidden = NO;
    faceBtn.alpha = 1;
    keyboard.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        //恢复原始
        _faceView.transform = CGAffineTransformIdentity;
        faceBtn.alpha = 0;

    } completion:^(BOOL finished) {
        keyboard .alpha = 1;
  
    }];
    
}
-(void)showKeyboard {
    if (self.isRepeatUseSth != YES) {
        
        [self.textView becomeFirstResponder];
    }
    


    _faceView.hidden = YES;
    UIButton *faceBtn = [_buttons objectAtIndex:4];
    UIButton *keyboard = [_buttons objectAtIndex:5];
    faceBtn.alpha = 0;
    keyboard.alpha = 1;
  
    [UIView animateWithDuration:0.3 animations:^{
        //恢复原始
        _faceView.transform = CGAffineTransformTranslate(_faceView.transform, 0, 736-44-20);
        keyboard .alpha = 0;
        
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
            faceBtn.alpha = 1;
//        }];
        
           keyboard.hidden = YES;
    }];
    
    
}
#pragma mark -textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    显示键盘
    self.isRepeatUseSth = YES;
    [self showKeyboard];
    self.isRepeatUseSth = NO;
    return YES;
}

-(void)buttonAction:(UIButton *)button {
    if (button.tag == 10) {
        [self location];
      
        
    }else if (button.tag == 11){
    
        [self selectImage];
    }else if (button.tag == 12){
    
    }else if(button.tag == 13){
    
    }else if(button.tag == 14){
        //显示表情
        [self showFaceView];
    }else if(button.tag == 15){
    //显示键盘

        [self showKeyboard];
    }

}

-(void)selectImage{
    UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"添加图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    

    
    UIAlertAction *uaa1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *uaa2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
      //拍照 (导航控制器)
        
        //判断用户设备是否有摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//        BOOL isCamera = NO;
        if (!isCamera) {
            UIAlertController *uac1 = [UIAlertController alertControllerWithTitle:@"启动失败" message:@"此设备没有摄像头" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            
            UIAlertAction *ua1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
            [uac1 addAction:ua1];
            [self presentViewController:uac1 animated:YES completion:nil];
        }else{
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera ;
            
            imagePicker.delegate = self;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    UIAlertAction *uaa3 = [UIAlertAction actionWithTitle:@"用户相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }];
    
 
    
    [uac addAction:uaa1];
    [uac addAction:uaa2];
    [uac addAction:uaa3];
    
    
    [self presentViewController:uac animated:YES completion:nil];

    
}
-(void)location {
    NearbyViewController *nearvc = [[NearbyViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nearvc];
    [self presentViewController:nvc animated:YES completion:nil];
    //result为nvc传递过来的数据
    nearvc.selectBlock = ^(NSDictionary *result){
        NSLog(@"%@",result);
        //记录位置信息
        _longtitude_b = [result objectForKey:@"lon"];

        _latitude_b = [result objectForKey:@"lat"];
        
        NSString *address = [result objectForKey:@"address"];
        if ([address isKindOfClass:[NSNull class]] || address.length == 0) {
            address = [result objectForKey:@"title"];
        }
        self.placeLabel.text = address;
        self.placeView.hidden = NO;
  
        UIButton *locationBtn = [_buttons objectAtIndex:0];
        locationBtn.selected = YES;
    };
    
 
}





#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
   UIImage *pickImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.sendImage = pickImage;
    
    
    if (self.sendImageBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        btn.frame = CGRectMake(10, 20, 25, 25);
        [btn addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sendImageBtn = btn;
        
    }
    
    [self.sendImageBtn setImage:pickImage forState:UIControlStateNormal];
    [self.editorBar addSubview:self.sendImageBtn];
    
    
    UIButton *btn1 = [_buttons objectAtIndex:0];
    UIButton *btn2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        btn1.transform = CGAffineTransformTranslate(btn1.transform, 20, 0);
        btn2.transform = CGAffineTransformTranslate(btn2.transform, 5, 0);
        
    }];
    
     [picker dismissViewControllerAnimated:YES completion:^{}];
}

//全屏放大
-(void)imageAction:(UIButton *)btn {
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
        _fullImageView.backgroundColor = [UIColor blackColor];
        _fullImageView.userInteractionEnabled = YES;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;   //拉伸
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageAction:)];
        [_fullImageView addGestureRecognizer:tap];
        
        
        //创建删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
        deleteButton.frame = CGRectMake(380, 30, 33, 33);
        [deleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.hidden = YES;
        deleteButton.tag = 33;
        
        [_fullImageView addSubview: deleteButton];
        
        
    }
    
    [self.textView resignFirstResponder];
    
    if (![_fullImageView superview]) {
        _fullImageView.image = self.sendImage;

        
        _fullImageView.frame = CGRectMake(10, 410, 25, 25);
       
        [self.view.window addSubview:_fullImageView];
        
        [UIView animateWithDuration:0.4 animations:^{
            _fullImageView.frame = CGRectMake(0, 0, 430, 736);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden = YES;
            //显示删除按钮
            [_fullImageView viewWithTag:33].hidden = NO;
        }];
    }
    
    
   
}
//取消图片
-(void)deleteImageAction:(UIButton *)deleteBtn {
    
    
    [self scaleImageAction:nil];
    //移除缩略图
    [_sendImageBtn removeFromSuperview];
    _sendImage = nil;
    
    
    UIButton *btn1 = [_buttons objectAtIndex:0];
    UIButton *btn2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        btn1.transform = CGAffineTransformIdentity;
        btn2.transform = CGAffineTransformIdentity;
        
    }];
    
  

    
}
//缩小图片
-(void)scaleImageAction:(UITapGestureRecognizer *)tap {
//隐藏删除按钮
    [_fullImageView viewWithTag:33].hidden = YES;
    
    
    [UIView animateWithDuration:0.4 animations:^{
        _fullImageView.frame =CGRectMake(10, 430, 25, 25);
    }completion:^(BOOL finished) {
        [_fullImageView removeFromSuperview];
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
    [self.textView becomeFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
