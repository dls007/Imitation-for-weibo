//
//  ViewController.m
//  HelloWeiboSample
//
//  Created by Liu Jim on 8/4/13.
//  Copyright (c) 2013 openlab. All rights reserved.
//

#import "ViewController.h"
#import "ThemeManager.h"


@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *statuses;
@end


@implementation ViewController {
    WeiboRequestOperation *_query;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

       [self setTitle:@"HOME"];
    
//    UIBarButtonItem *bindBtn = [UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@select
    UIBarButtonItem *bindBtn = [[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStylePlain target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = bindBtn;
    
    UIBarButtonItem *signoutBtn =[[UIBarButtonItem alloc]initWithTitle:@"注销账号" style:UIBarButtonItemStylePlain target:self action:@selector(signoutAction:)];
    self.navigationItem.leftBarButtonItem = signoutBtn;
    
    
  
    
    
    
    
    
}


- (void)bindAction:(UIBarButtonItem *)btn
{
    
        [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
            if (!error) {
                NSLog(@"Sign in successful: %@", account.user.screenName);
            }
       
        }];
    
   
        [self loadStatuses];
    

}
- (void)signoutAction:(UIBarButtonItem *)btn
{
    Weibo *weibo = [[Weibo alloc] initWithAppKey:kAppKey withAppSecret:kAppSecret withRedirectURI:kRedirectURI];
    [weibo signOut];
    if (weibo.isAuthenticated) {
        NSLog(@"current user: %@", weibo.currentAccount.user.name);
    }else{
    NSLog(@"current user: %@", weibo.currentAccount.user.name);
    }
    
    
    ViewController *VC = [[ViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    if (![Weibo.weibo isAuthenticated]) {
        [Weibo.weibo authorizeWithCompleted:^(WeiboAccount *account, NSError *error) {
            if (!error) {
                NSLog(@"Sign in successful: %@", account.user.screenName);
            }
            else {
                NSLog(@"Failed to sign in: %@", error);
            }
        }];
    }
    else {
        [self loadStatuses];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadStatuses {
    self.statuses = nil;
    if (_query) {
        [_query cancel];
    }
    [self.tableView reloadData];
    

    
    
    
    _query = [Weibo.weibo queryTimeline:StatusTimelineFriends count:50 completed:^(NSMutableArray *statuses, NSError *error) {
        if (error) {
            self.statuses = nil;
            NSLog(@"error:%@", error);
        }
        else {
            self.statuses = statuses;
//               NSLog(@"%@",self.statuses);
        }
        _query = nil;
        [self.tableView reloadData];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_query) { // loading...
        return 1;
    }
    if (!self.statuses) {
        return 1;
    }
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_query) { // loading...
        cell.textLabel.text = @"Loading...";
    }
    else if (!self.statuses) {
        cell.textLabel.text = @"Failed to load...";
    }
    else {
        Status *status = [_statuses objectAtIndex:indexPath.row];
        cell.textLabel.text = status.text;
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}



@end

