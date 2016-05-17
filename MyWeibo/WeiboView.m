//
//  WeiboView.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/23.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "Status.h"
#import "UIImageView+webCatch.h"
#import "TTTAttributeLabelView.h"
#import "NSString+RichText.h"
#import "TTTAttributedLabel.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "CONSTS.h"
#import "UIView+Addtions.h"
#import "UserViewController.h"
#import "WebViewController.h"


#define LIST_FONT 14.0f                 //列表中的微博文本字体
#define LIST_REPOST_FONT 13.0f          //列表中转发的文本字体
#define DETAIL_FONT 16.0f               //详情的文本字体
#define DETAIL_REPOST_FONT 17.0f        //详情中转发的文本字体

@interface WeiboView () <TTTAttributeLabelViewDelegate>



@end

@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return  self;
}

//初始化子视图
- (void)_initView {
    
    //微博内容
    _textLable = [[UILabel alloc]init];
    _textLable.numberOfLines = 0;
    _textLable.font = [UIFont systemFontOfSize:14.0f];


    
    //textView微博内容
    // 初始化对象

       self.attributeLabelView                    = [[TTTAttributeLabelView alloc] init];

    self.attributeLabelView.delegate           = self;
    self.attributeLabelView.linkColor          = [UIColor blueColor];
    if (self.isDetail) {

    }
    [self addSubview:self.attributeLabelView];
    
    //微博图片
    _image = [[UIImageView alloc]initWithFrame:CGRectZero];
    _image.image = [UIImage imageNamed:@"微博.png"];
    [self addSubview:_image];
    
    //转发微博的背景图片
    _repostBackgroundView = [UIFactory createThemeImage:@"chatfrom_bg_normal.png"];
//    //拉伸
    UIImage *image = [_repostBackgroundView.image stretchableImageWithLeftCapWidth:_repostBackgroundView.image.size.width*0.5 topCapHeight:_repostBackgroundView.image.size.height*0.7];
    _repostBackgroundView.image = image;

    _repostBackgroundView.backgroundColor = [UIColor clearColor];

    [self insertSubview:_repostBackgroundView atIndex:0];



}



//布局  展示数据 子视图布局
- (void)layoutSubviews {
    [super layoutSubviews];
    //------------------微博内容TextView子视图---------------------------------
    [self _renderTextView];
    
    
    //------------------转发的微博视图---------------------------------
    [self _renderRepostView];
    //------------------微博图片视图---------------------------------
    
    
    [self _renderWeiboImage];
    
    
    //------------------转发微博视图背景_repostBackgroundView---------------------------------

    [self _renderWeiboBackgroundImage];
    
   
}
- (void)_renderWeiboBackgroundImage {
    if (self.isRepost) {
        _repostBackgroundView.frame = CGRectMake(-30, 0, 414-30, self.bounds.size.height);
        _repostBackgroundView.hidden = NO;
        //拉伸
        //            UIImageView *themeBackgroundView = [UIFactory createThemeImage:@"chatfrom_bg_normal.png"];
        //            UIImage *image = [themeBackgroundView.image stretchableImageWithLeftCapWidth:_repostBackgroundView.image.size.width*0.5 topCapHeight:_repostBackgroundView.image.size.height*0.7];
        if (self.isDetail) {
            _repostBackgroundView.frame = CGRectMake(-30, 20, 414-30, self.bounds.size.height);
            _repostBackgroundView.hidden = NO;
        }
        //            [_repostBackgroundView setImage:image];
    }else{
        _repostBackgroundView.hidden = YES;
    }
}

- (void)_renderWeiboImage {
        //------------------微博图片视图---------------------------------
    //    NSLog(@"中等%@",_weiboModel.bmiddleImageUrl);
    if (self.isDetail) {
        //中等大小视图
        NSString *bmiddlImage = _weiboModel.bmiddleImageUrl;
        //不为空  并且字符串不为空
        if (bmiddlImage  != nil ) {
            _image.hidden = NO;
            _image.frame = CGRectMake(30,self.attributeLabelView.frame.size.height + 20, 280 , 200);
            //加载网络图片数据
            [_image setImagewithURL:[NSURL URLWithString:bmiddlImage]];
            //        [_image setImage:[UIImage imageNamed:@"chatfrom_bg_normal.png"]];
        }else{
            _image.hidden = YES;
        }
    }else{
        //获取当前浏览模式
        NSInteger mode = [[NSUserDefaults standardUserDefaults]integerForKey:kBrowseMode];
        if (mode == 0) {
            mode = SmallBrowseMode;
        }
        
        if (mode == SmallBrowseMode) {
            //缩略图
            NSString *thumbnailImage = _weiboModel.thumbnailImageUrl;
            //不为空  并且字符串不为空
            if (thumbnailImage != nil ) {
                _image.hidden = NO;
                _image.frame = CGRectMake(10,self.attributeLabelView.frame.size.height + 5, 70, 80);
                //加载网络图片数据
                [_image setImagewithURL:[NSURL URLWithString:thumbnailImage]];
                //        [_image setImage:[UIImage imageNamed:@"chatfrom_bg_normal.png"]];
            }else{
                _image.hidden = YES;
            }
        }else if (mode == LargeBrowseMode){
            //中等大小视图
            NSString *bmiddlImage = _weiboModel.bmiddleImageUrl;
            //不为空  并且字符串不为空
            if (bmiddlImage  != nil ) {
                _image.hidden = NO;
                _image.frame = CGRectMake(30,self.attributeLabelView.frame.size.height + 5, 280 , 200);
                //加载网络图片数据
                [_image setImagewithURL:[NSURL URLWithString:bmiddlImage]];
                //        [_image setImage:[UIImage imageNamed:@"chatfrom_bg_normal.png"]];
            }else{
                _image.hidden = YES;
            }

        }
        
        
        
    }
    
    

}

- (void)_renderTextView{
    //------------------微博内容_textLable子视图---------------------------------
    //获取字体大小
    float fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLable.font = [UIFont systemFontOfSize:fontSize];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName,nil];
    
    
    // 计算文本的大小
    //    NSLog(@"%f",_textLable.bounds.size.height);
    CGSize textSize = [[NSString stringWithFormat:@"%@",_attributeLabelView.attributedString] boundingRectWithSize:_attributeLabelView.bounds.size // 用于计算文本绘制时占据的矩形块
                                                                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                                                                        attributes:tdic        // 文字的属性
                                                                                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    
    
    
    //    _textLable.frame = CGRectMake(0, 0,kweibo_width_List,20);
    
    
    //NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_weiboModel.text];
    
    
    
    
    //------------------微博内容_textView子视图---------------------------------
    
    self.attributeLabelView.frame = CGRectMake(0, 0,kweibo_width_List,40);
    
    
    
    //判断当前视图是否为转发视图
    if (_repostView != nil) {
        //        _textLable.frame = CGRectMake(0, 0, 350, 20);
        //        NSLog(@"cgpoint %@",NSStringFromCGRect(_textLable.frame));
        //        NSLog(@" 转发内容%@",_weiboModel.text);
    }
    //    _textLable.text = _weiboModel.text;
    
    //    NSLog(@"%@",_weiboModel.text);
    

}

-(void)_renderRepostView {
    //转发的微博model
    Status *repostWeibo = _weiboModel.retweetedStatus;
    if (repostWeibo != nil) {
        _repostView.weiboModel = repostWeibo;
        
        //高度通过类方法计算
        CGFloat height = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(10,45, self.frame.size.width,height);
        _repostView.hidden = NO;
    }else {
        _repostView.hidden = YES;
    }
}


- (void)setWeiboModel:(Status *)weiboModel
{
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
    }
    
//    //创建微博转发视图
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        [self addSubview:_repostView];
    }
    [self praseLink];

}


//解析超链接
- (void)praseLink {
    NSString *content = nil;
    if (_isRepost) {
        //将源微博作者拼接
       NSString *nickName = _weiboModel.user.screenName;
        if (nickName.length>0) {
             nickName = [@"@" stringByAppendingString:nickName];
            content = [nickName stringByAppendingString:_weiboModel.text];
        }else{
        content = _weiboModel.text;
        }
       
        
    }else if (!_isRepost){
        content = _weiboModel.text;
    }

    NSString *string = content;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing              = .1f;
    style.paragraphSpacing         = style.lineSpacing * 1;
    style.alignment                = NSTextAlignmentCenter;
    
   CGFloat fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    NSAttributedString *attributedString  = \
    [string createAttributedStringAndConfig:@[[ConfigAttributedString foregroundColor:[UIColor blackColor] range:string.range],
                                              [ConfigAttributedString paragraphStyle:style range:string.range],
                                              [ConfigAttributedString font:[UIFont fontWithName:@"American Typewriter" size:fontSize] range:string.range]]];
    
    self.attributeLabelView.attributedString   = attributedString;
    
    
  
    

    
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSArray *texts = [string componentsMatchedByRegex:regex];
    for (NSString *linkString in texts) {
        //        NSLog(@"%@",s);
        //        NSString *target = [NSString stringWithFormat:@"<a herf='%@'>%@</a>",s,s];
        //        string = [string stringByReplacingOccurrencesOfString:s withString:target];
        NSString *replacing = nil;
        if ([linkString hasPrefix:@"@"]) {
            replacing = [NSString stringWithFormat:@"user://%@",[linkString URLEncodedString]];
        }else if ([linkString hasPrefix:@"http"]){
            replacing = [NSString stringWithFormat:@"%@",linkString];
            
        }else if ([linkString hasPrefix:@"#"]){
            
            replacing = [NSString stringWithFormat:@"topic://%@",[linkString URLEncodedString]];
            
        }
          // 添加超链接
        NSRange range = [string rangeOfString:linkString];
        [self.attributeLabelView addLinkStringRange:range flag:replacing];
//        NSLog(@"%@",replacing);
    }
    
    // 进行渲染
    [self.attributeLabelView render];
    [self.attributeLabelView resetSize];
    
}


//获取字体的大小
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost {
    float fontSize = 14.0f;
    
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }else if (!isDetail && isRepost){
        return LIST_REPOST_FONT;
    }else if (isDetail && !isRepost){
        return DETAIL_FONT;
    }else if (isDetail && isRepost){
        return DETAIL_REPOST_FONT;
    }
    
    
    return fontSize;
}
+ (CGFloat)getWeiboViewHeight:(Status *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetail {

    /*
            实现思路 分别计算每个子视图的高度 然后相加
          (类方法不能直接拿到子视图_textLable)
          */
        float height = 0;
    
        //-----------------计算微博内容text的高度--------------------

        //判断微博是否为详情页面
//        if (isDetail) {
//            CGRect frame = [textLable frame];
//            frame.size.width = kweibo_width_Detial;
//        }else {
//            CGRect frame = [textLable frame];
//            frame.size.width = kweibo_width_List;
//        }
        height += 20;

    //    //-------------------计算微博图片的高度----------------------
    
    if (isDetail) {
        NSString *bmiddleImageUrl = weiboModel.bmiddleImageUrl;
        
        if (bmiddleImageUrl != nil ) {
            height += (200 + 10);
        }
    }else{
        NSInteger mode = [[NSUserDefaults standardUserDefaults]integerForKey:kBrowseMode];
        
        if (mode == 0) {
            mode = SmallBrowseMode;
        }
        
        if (mode == SmallBrowseMode) {
        NSString *thumbnailImage = weiboModel.thumbnailImageUrl;
        
        if (thumbnailImage != nil ) {
            height += (80 + 10);
            }
        }else if (mode == LargeBrowseMode){
            NSString *bmiddleImageUrl = weiboModel.bmiddleImageUrl;
            
            if (bmiddleImageUrl != nil ) {
                height += (200 + 10);
            }
        
        }
    }
    
    //    //－－－－－－－－－－－－计算转发微博视图的高度－－－－－－－－－－－－－－
    
   
        Status *relWeibo = weiboModel.retweetedStatus;
        if (relWeibo != nil) {
            //转发微博视图的高度
           CGFloat repostHeight = [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
            height += repostHeight;
        }
    if (isRepost) {
        height += 35;
    }
    
    return height;
}
- (void)TTTAttributeLabelView:(TTTAttributeLabelView *)attributeLabelView linkFlag:(NSString *)flag {
    NSString *urlString = [flag URLDecodedString];
    NSLog(@"%@", urlString);
    if([urlString rangeOfString:@"user://@"].location !=NSNotFound)//_roaldSearchText
    {
        UserViewController *uvc = [[UserViewController alloc]init];
         uvc.weiboModel = self.weiboModel;
        
        [self.viewController.navigationController pushViewController:uvc animated:YES];
        
        NSLog(@"跳转用户资料");
        
    }
    else if ([urlString rangeOfString:@"http://"].location !=NSNotFound)
    {
        WebViewController *wvc = [[WebViewController alloc]initWithURL:urlString];
        
        [wvc.tabBarController hidesBottomBarWhenPushed];
        
//        self.viewController.navigationController.tabBarController.tabBar.hidden=YES;
//        self.viewController.navigationController.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController presentViewController:wvc animated:YES completion:nil];
        
        NSLog(@"跳转到网页");
        
    }else if ([urlString rangeOfString:@"topic://#"].location !=NSNotFound){
        
        NSLog(@"跳转话题");
        
    }
    

    
    
}
@end
