//
//  NearbyViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/4/14.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

//定义一个block
typedef void(^SelectDoneBlock)(NSDictionary *);


@interface NearbyViewController : BaseViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSArray *data;
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longtitude;
//将block声明成属性
@property (nonatomic,copy)SelectDoneBlock selectBlock;
@property (nonatomic,assign )BOOL isCancelPlaceView;



@end
