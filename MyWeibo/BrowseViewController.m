//
//  BrowseViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/6.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BrowseViewController.h"
#import "CONSTS.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片浏览模式";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

//返回某一行对应的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0.用static修饰的局部变量只会初始化一次，结束时销毁
    static NSString *ID = @"model";
    //1.先去缓存池找对应标示的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果缓存池没有对应的cell再创建新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"大图模式";
        cell.detailTextLabel.text = @"所有网络加载大图";
    }else if (indexPath.row == 1) {
            cell.textLabel.text = @"小图模式";
            cell.detailTextLabel.text = @"所有网络加载小图";
    }
        
    
    //3.0覆盖数据
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger mode = -1;
    
    if (indexPath.row == 0) {
        mode = LargeBrowseMode;
    }else if (indexPath.row == 1){
        mode = SmallBrowseMode;
    }
    [[NSUserDefaults standardUserDefaults]setInteger:mode forKey:kBrowseMode];
    [[NSUserDefaults standardUserDefaults]synchronize]; // 同步到本地
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadWeiboTableViewNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
