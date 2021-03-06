//
//  LocationService.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LocationService.h"
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface LocationService ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong)BMKGeoCodeSearch* geoCoder;
@property(nonatomic,copy)FinishLocalBlock localBlock;
@property(nonatomic,copy)FinishGeocodeBlock geocodeBlock;
@end

@implementation LocationService

+ (void)getCoordWithBlock:(FinishLocalBlock)block{

    static LocationService *baseManager = nil;
    if (baseManager == nil) {
        baseManager = [[self allocWithZone:nil] init];
        [baseManager stup];
    }
      [baseManager.locService startUserLocationService];
    baseManager.localBlock = block;
}

+ (void)getAdressWithBlock:(FinishGeocodeBlock)block{

    static LocationService *baseManager = nil;
    if (baseManager == nil) {
        baseManager = [[self allocWithZone:nil] init];
        [baseManager stup];
    }
    [baseManager.locService startUserLocationService];
    baseManager.geocodeBlock = block;
}

-(void)stup{
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //初始化BMKLocationService
    _locService.delegate = self;
    
    _geoCoder = [[BMKGeoCodeSearch alloc]init];
    _geoCoder.delegate = self;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
  
    if (self.localBlock) {
        self.localBlock(userLocation.location.coordinate);
        
        if (!self.geocodeBlock) {
            [_locService stopUserLocationService];
            return;
        }
    }
    BMKReverseGeoCodeOption* option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = userLocation.location.coordinate;
    
    [_geoCoder reverseGeoCode:option];

}
- (void)didFailToLocateUserWithError:(NSError *)error{

    NSLog(@"定位失败 error == %@" ,error);
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{

    if (error) {
        NSLog(@"反编码失败");
        return;
    }
    LocationModel* model = [[LocationModel alloc]init];
    model.address = result.address;
    model.streetNumber = result.addressDetail.streetNumber;
    model.streetName = result.addressDetail.streetName;
    model.district = result.addressDetail.district;
    model.city = result.addressDetail.city;
    model.province = result.addressDetail.province;
    model.coord = result.location;
    
    if (self.geocodeBlock) {
        self.geocodeBlock(model);
    }
    [_locService stopUserLocationService];
}

-(void)dealloc{
    _locService.delegate = nil;
    _geoCoder.delegate = nil;
    _locService = nil;
    _geoCoder = nil;
}

@end

@implementation LocationModel

@end
