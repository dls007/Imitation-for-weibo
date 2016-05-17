//
//  NearbyWeiboAnnotation.m
//  MyWeibo
//
//  Created by DLS-MACMini on 16/5/9.
//  Copyright © 2016年 DLS-MACMini. All rights reserved.
//

#import "NearbyWeiboAnnotation.h"

@implementation NearbyWeiboAnnotation

-(id)initWithWeibo:(Status *)weibo{
    
    
    self = [super init];
    if (self != nil) {
        self.weiboModel = weibo;
    }
    
    
    return self;
    
}
-(void)setWeiboModel:(Status *)weiboModel {
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
    }
    
    
    if ((NSNull *)weiboModel.geo != [NSNull null]) {
        double lat = weiboModel.geo.latitude;
        double lon = weiboModel.geo.longitude;
        CLLocationCoordinate2D coord = {lat,lon};
        _coordinate  = coord;
    }
}
@end
