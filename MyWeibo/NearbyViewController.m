//
//  NearbyViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/14.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "NearbyViewController.h"
#import "Weibo.h"
#import "UIImageView+webCatch.h"
#import "UIFactory.h"


@interface NearbyViewController ()

@end

@implementation NearbyViewController
{
    WeiboRequestOperation *_query;
   
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isBackButton = NO;
    self.isCancelPlaceView = NO;
    self.title = @"我在这里";
    
    CGRect frame = CGRectMake(0, 0, 40, 30);
    UIButton *button = [UIFactory createNavigationButton:frame title:@"取消"];
    [button addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem= cancleItem;
    
    
    
    UIButton *button2 = [UIFactory createNavigationButton:frame title:@"定位"];
    [button2 addTarget:self action:@selector(getLocationAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *iconItem = [[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem= iconItem;
    
    
    self.tableView.hidden = YES;

    [super showHUDWithNoMask];
    
    CLLocationManager *locationManager;//定义Manager
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        self.locationManager = locationManager;
        self.locationManager.delegate = self;
        //        requestWhenInUseAuthorization()
        //        或者
        //        requestAlwaysAuthorization()
        //使用期间允许
        [self.locationManager requestWhenInUseAuthorization];
        //总是允许
        [self.locationManager requestAlwaysAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }else {
        //提示用户无法进行定位操作
    }

     [self.locationManager startUpdatingLocation];
    
    
}
-(void)getLocationAction{
    [self.locationManager startUpdatingLocation];
    NSLog(@"start");
    [self.tableView reloadData];
    [super dismissHUD];
}


-(void)cancleAction{
    NSLog(@"cancle");
    self.isCancelPlaceView = YES;
    [super dismissHUD];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - MapKit Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    self.latitude =  coor.latitude;
    self.longtitude = coor.longitude;
    NSLog(@"latitude:%f longtitude:%f",self.latitude,self.longtitude);
    
    
    NSLog(@"ok!!!");
    
    CLGeocoder *geocoder = [[CLGeocoder alloc ]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSLog(@"name:%@",place.name);                          //位置名
            NSLog(@"throughfare:%@",place.thoroughfare);          //街道
            NSLog(@"subThoroughfare:%@",place.subThoroughfare);  //子街道
            NSLog(@"locality:%@",place.locality);               //市
            NSLog(@"subLocality:%@",place.subLocality);        //区
            NSLog(@"country:%@",place.country);               //国家
            
            
        }
    }];
    
    [self.locationManager stopUpdatingLocation];
    
    
    
    if (_data == nil) {
        float longtitude = self.longtitude;
        float latitude = self.latitude;
        
        _query = [[Weibo weibo]getNearby:longtitude latitude:latitude completed:^(NSMutableArray *statuses, NSError *error) {
            _data = statuses;
            [self refreshUI];

        }];
    }
}

-(void)refreshUI {
    self.tableView.hidden = NO;
    [super dismissHUD];
    [self.tableView reloadData];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        NSLog(@"%@",error);
    }
}

//返回某一行对应的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0.用static修饰的局部变量只会初始化一次，结束时销毁
    static NSString *ID = @"nearby";
    //1.先去缓存池找对应标示的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果缓存池没有对应的cell再创建新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
    
    NSString *title = [dic objectForKey:@"title"];
    NSString *address = [dic objectForKey:@"address"];
    NSString *icon = [dic objectForKey:@"icon"];
    
  
    cell.textLabel.text = title;
    
    
    if ((NSNull *)address == [NSNull null]) {
        address = @"";
    }
    
    
    cell.detailTextLabel.text = address;
    [cell.imageView setImagewithURL:[NSURL URLWithString:icon]];
    
    //3.0覆盖数据
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
    
}

//使用block 在控制器之间传递参数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectBlock != nil) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        _selectBlock(dic);

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
