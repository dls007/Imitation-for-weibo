//
//  ThemeViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/3/1.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
#import "UIFactory.h"
#import "CONSTS.h"



@interface ThemeViewController ()
{
    NSArray *themes;
    UILabel *myLable;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    themes = [[ThemeManager shareInstance].themesPlist allKeys];
    self.title = @"主题切换";
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return themes.count;
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
        
        myLable = [UIFactory createThemeLable:kNavigationBarTitleLable];
        myLable.frame = CGRectMake(0, 10, 200, 30);
        myLable.backgroundColor = [UIColor clearColor];
        myLable.font = [UIFont systemFontOfSize:16.0f];
        [cell.contentView addSubview:myLable];
        
    }
    
    
    NSString *name = themes[indexPath.row];
    myLable.text = name;
    
    NSString *themeNmae = [ThemeManager shareInstance].themeName;
    if (themeNmae == nil) {
        themeNmae = @"默认";
    }
    if ([themeNmae isEqualToString:name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
    cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    
    
//    cell.textLabel.text = themes[indexPath.row];
   

    
    //3.0覆盖数据
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString *themeName = themes[indexPath.row];
    
    if([themeName isEqualToString:@"默认"]){
        themeName = nil;
    }
    
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults]setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [ThemeManager shareInstance].themeName = themeName;
    [[NSNotificationCenter defaultCenter]postNotificationName:kThemeDidChangeNotification object:themeName];
    
    [tableView reloadData];

}

@end
