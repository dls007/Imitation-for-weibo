//
//  FriendshipsCell.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/29.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "FriendshipsCell.h"
#import "UserGridView.h"
@class User;
@implementation FriendshipsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        
    }
    return self;
}
-(void)initViews {

    for (int i = 0 ; i < 3; i++) {
        UserGridView *gridView = [[UserGridView alloc]initWithFrame:CGRectMake(120 * i+40, 10, 96, 96)];
        gridView.tag = 2016+i;
//        User *userModel = [self.data objectAtIndex:i];
//        gridView.userModel = userModel;

//    NSLog(@"%@",self.data);
        [self.contentView addSubview:gridView];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    for (int i =0; i<3; i++) {
        User *userModel = [self.data objectAtIndex:i];
        int tag = 2016+i;
        UserGridView *gridView = (UserGridView *)[self.contentView viewWithTag:tag];
        gridView.frame = CGRectMake(120 * i+40, 10, 50, 50);
                gridView.userModel = userModel;
        
        gridView.hidden = NO;
        
        //tableViewCell复用不回调用layoutSubview  需要使用 setNeedsLayout（让gridView异步调用layoutSubview）
        [gridView setNeedsLayout];
        
//            NSLog(@"1231231%@",self.data);
    }
   
}


#pragma mark - 复写setData 隐藏被复用时没有真实数据的gridView
-(void)setData:(NSArray *)data {
    
    if (_data != data) {
        _data = data;
    }
    
    for (int i =0; i<self.data.count; i++) {
          int tag = 2016+i;
        UserGridView *gridView = (UserGridView *)[self.contentView viewWithTag:tag];
        
        
        gridView.hidden = YES;
    }

    
}
@end
