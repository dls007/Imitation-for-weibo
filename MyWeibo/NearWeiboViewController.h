//
//  NearWeiboViewController.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearWeiboViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,retain)NSArray *data;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
