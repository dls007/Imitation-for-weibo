//
//  NearbyWeiboAnnotation.h
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

#import <MapKit/MapKit.h>

@interface NearbyWeiboAnnotation : NSObject<MKAnnotation>

@property (nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property (nonatomic,retain)Status *weiboModel;

-(id)initWithWeibo:(Status *)weibo;
@end
