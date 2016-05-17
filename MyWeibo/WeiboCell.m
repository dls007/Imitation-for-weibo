//
//  WeiboCell.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/23.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "WeiboCell.h"
#import "Status.h"
#import "UIImageView+webCatch.h"
#import "WeiboView.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "UserViewController.h"
#import "UIView+Addtions.h"

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {



        [self _initView];
    }
    
    return  self;
}

//初始化子视图
- (void)_initView {
    //用户头像
    _userImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;
    _userImage.layer.borderWidth = 0.5;
    _userImage.layer.borderColor = [UIColor brownColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    _userImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUser:)];
    [_userImage addGestureRecognizer:singleTap];
    [self.contentView addSubview:_userImage];
    
    
    //用户昵称
    _nickLable = [[UILabel alloc]initWithFrame:CGRectZero];
    _nickLable.backgroundColor = [UIColor clearColor];
    _nickLable.font = [UIFont systemFontOfSize:14.0];
    _nickLable.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:_nickLable];
    
  
    // ----------------微博视图_weiboView-----------------
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];

    //转发数
    _repostCountLable = [[UILabel alloc]initWithFrame:CGRectZero];
    _repostCountLable.font = [UIFont systemFontOfSize:12.0f];
    _repostCountLable.backgroundColor = [UIColor clearColor];
    _repostCountLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLable];
    
    //回复数
    _commentLable = [[UILabel alloc]initWithFrame:CGRectZero];
    _commentLable.font = [UIFont systemFontOfSize:12.0f];
    _commentLable.backgroundColor = [UIColor clearColor];
    _commentLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLable];
    
    //微博来源(设备)
    _sourceLable = [[UILabel alloc]initWithFrame:CGRectZero];
    _sourceLable.font = [UIFont systemFontOfSize:12.0f];
    _sourceLable.backgroundColor = [UIColor clearColor];
    _sourceLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLable];
    
    //发布时间
    _createLable = [[UILabel alloc]initWithFrame:CGRectZero];
    _createLable.font = [UIFont systemFontOfSize:12.0f];
    _createLable.backgroundColor = [UIColor clearColor];
    _createLable.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLable];
    
}
-(void)openUser:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"openUser");
    
    UserViewController *uvc = [[UserViewController alloc]init];
    uvc.weiboModel = self.weiboModel;
    [self.viewController.navigationController pushViewController:uvc animated:YES];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //----------------用户头像 _userImage------------------
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSString *userImageUrl =  _weiboModel.user.profileImageUrl;
    [_userImage setImagewithURL:[NSURL URLWithString:userImageUrl]];
    
    // ----------------昵称_nickLable-----------------
    _nickLable.frame = CGRectMake(50, 10, 200, 20);
    _nickLable.text = _weiboModel.user.screenName;
    
    NSLog(@"%@",_nickLable.text);
    
    // ----------------微博视图_weiboView-----------------

    _weiboView.weiboModel = _weiboModel;
    CGFloat h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLable.frame.size.height + 10, kweibo_width_List, h);
    
    // ----------------发布时间_createLable-----------------
    //源日起字符串 Tue May 31 17:46:55 +0800 2011
    // E M d HH:mm:ss Z yyyy
    //目标日起字符串 01-23 14:52
    
    NSString *createDate = [NSString stringWithFormat:@"%ld",_weiboModel.createdAt];
    if (createDate != nil) {
        //        NSDate *date = [UIUtils dateFromFormat:createDate format:@"E M d HH:mm:ss Z yyyy"];
        //        NSString *dateString = [UIUtils stringFromFormat:date format:@"MM-dd HH:ss"];
        //        _createLable.text = dateString;
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:_weiboModel.createdAt];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        //        NSLog(@"confromTimespStr =  %@",confromTimespStr);
        _createLable.text = confromTimespStr;
        _createLable.frame = CGRectMake(50, self.bounds.size.height - 20, 80, 20);
        [_createLable sizeToFit];
        //        NSLog(@"   发布时间%@",confromTimespStr);
        _createLable.hidden = NO;
    }else{
        _createLable.hidden = YES;
    }

    
    // ----------------发布来源_sourceLable-----------------
    NSString *source = _weiboModel.source;
    //    NSLog(@"来自%@",source);
    //    NSString *ret = [self parseSource:source];
    if (source != nil) {
        //        _sourceLable.text = [NSString stringWithFormat:@"来自%@",ret];
        _sourceLable.text = [NSString stringWithFormat:@"来自%@",source];
        _sourceLable.frame = CGRectMake(_createLable.frame.origin.x+_createLable.frame.size.width + 20, self.bounds.size.height - 20, 100, 20);
        
        [_sourceLable sizeToFit];
        
        _sourceLable.hidden = NO;
    }else {
        _sourceLable.hidden = YES;
    }
    
    // ----------------转发数_repostCountLable-----------------
    int repostCount =_weiboModel.repostsCount;
    if (repostCount != 0) {
        
        _repostCountLable.text = [NSString stringWithFormat:@"转发数:%d",repostCount];
        _repostCountLable.frame = CGRectMake(_sourceLable.frame.origin.x+_sourceLable.frame.size.width + 20, self.bounds.size.height - 22, 60, 20);        _repostCountLable.hidden =NO;
    }else {
        _repostCountLable.hidden = YES;
    }
    
    // ----------------回复数_commentLable-----------------
    int commentsCount =_weiboModel.commentsCount;
    if (commentsCount != 0) {
        
        _commentLable.text = [NSString stringWithFormat:@"评论数:%d",commentsCount];
        if (repostCount != 0) {
            _commentLable.frame = CGRectMake(_repostCountLable.frame.origin.x+_repostCountLable.frame.size.width, self.bounds.size.height - 22, 100, 20);
        }else{
        
            _commentLable.frame = CGRectMake(_sourceLable.frame.origin.x+_sourceLable.frame.size.width + 20, self.bounds.size.height - 22, 100, 20);
        }
        _commentLable.hidden =NO;
    }else {
        _commentLable.hidden = YES;
    }

    
}

//- (NSString *)parseSource:(NSString *)source {
//    NSString *regex = @">\\w+<";
//    NSArray *array = [source componentsMatchedByRegex:regex];
//    if (array.count > 0) {
//        //>新浪微博<
//        NSString *ret = [array objectAtIndex:0];
//        //设置范围截取字符串
//        NSRange range ;
//        range.location = 1;
//        range.length = ret.length - 2;
//        NSString *resultString = [ret substringWithRange:range];
//        return resultString;
//    }else {
//        return nil;
//    }
//}

@end
