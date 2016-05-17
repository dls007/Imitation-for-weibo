//
//  NearWeiboViewController.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "NearWeiboViewController.h"
#import "DataService.h"
#import "Status.h"
#import "NearbyWeiboAnnotation.h"
#import "WeiboAnnotationView.h"

@interface NearWeiboViewController ()

@end

@implementation NearWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    self.locationManager = locationManager;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

#pragma  mark -CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    

    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {coor,span};
    [self.mapView setRegion:region animated:YES];
    //    self.latitude =  coor.latitude;
    //    self.longtitude = coor.longitude;
    //    NSLog(@"latitude:%f longtitude:%f",self.latitude,self.longtitude);
    
    
    NSLog(@"ok!!!");
    //反编码
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
    
    
    if (self.data == nil) {
        
        NSString *lon = [NSString stringWithFormat:@"%f",coor.longitude];
        NSString *lat = [NSString stringWithFormat:@"%f",coor.latitude];
        
        [self loadNearWeiboData:lon latitude:lat];
        
    }
    
    
    
}
-(void)loadNearWeiboData:(NSString *)lon latitude:(NSString *)lat {

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:lon,@"long",lat,@"lat", nil ];
    
    [DataService requsetWithURL:@"place/nearby_timeline.json" params:params httpMethod:@"GET" completeBlock:^(id result) {
        [self loadDataFinish:result];
    }];
    
}
-(void)loadDataFinish:(NSDictionary *)result {
    NSArray *statues = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    
    for ( int i = 0 ;i<statues.count; i ++) {
        NSDictionary *statuesDic = [statues objectAtIndex:i];
        Status *weibo = [[Status alloc]initWithJsonDictionary:statuesDic];
        [weibos addObject:weibo];
        
        
        //将每个weibo对象创建Annotation对象填充到地图上
        NearbyWeiboAnnotation *weiboAnnotation = [[NearbyWeiboAnnotation alloc]initWithWeibo:weibo];
//        [self.mapView addAnnotation:weiboAnnotation];
        //延迟添加annotation 动画效果也会有延迟出现的效果
        [self.mapView performSelector:@selector(addAnnotation:) withObject:weiboAnnotation afterDelay:i*0.1];
    }
    
}

#pragma mark - mapViewDelegate
//返回标注视图（大头针视图）
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    //如果是用户位置 就会创建默认标志视图
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    
    
    
    
    
    
    
    
    static NSString *identifier = @"WeiboAnnotationView";
    
    WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView == nil) {
        //        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        
       
        annotationView = [[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
       
    }
    //如果出现复用   将最新的数据传给它
    annotationView.annotation = annotation;
    
    
    
    
    return annotationView;
}


-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{

    for (UIView *annotationView in views) {
        
        //0.7--->1.2...1.2--->1             alpha 0 -->1
        //原始动画数据
        CGAffineTransform transform = annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotationView.alpha = 0 ;
        
        //从无先放大再缩小到正常尺寸
        [UIView animateWithDuration:0.3 animations:^{
            //动画1
            annotationView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
            annotationView.alpha = 1;
        } completion:^(BOOL finished) {
           //动画2
            [UIView animateWithDuration:0.3 animations:^{
                annotationView.transform = CGAffineTransformIdentity;
            }];
        }];
        
        
        
    }
}
@end
