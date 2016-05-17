//
//  SettingViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/2/26.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "SettingViewController.h"
#import "ThemeViewController.h"
#import "BrowseViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setting";
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回某一行对应的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0.用static修饰的局部变量只会初始化一次，结束时销毁
    static NSString *ID = @"cell";
    //1.先去缓存池找对应标示的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果缓存池没有对应的cell再创建新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"主题";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"图片浏览模式";
    }
    
    //3.0覆盖数据
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ThemeViewController *tVC = [[ThemeViewController alloc]init];
        [self.navigationController pushViewController:tVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        BrowseViewController *bVC = [[BrowseViewController alloc]init];
        [self.navigationController pushViewController:bVC animated:YES];
    }
    
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//   
//    
//    
//    
//}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *uil = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 414, 40)];
    uil.tag = section;
    NSString *head = @"界面";
    uil.text = head;
    uil.font = [UIFont systemFontOfSize:18];
    uil.textAlignment = NSTextAlignmentCenter;
    uil.textColor = [UIColor blackColor];
    
    return uil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
@end
