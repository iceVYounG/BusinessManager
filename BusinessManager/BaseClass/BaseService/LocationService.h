//
//  LocationService.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/29.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@class LocationModel;

typedef void(^FinishGeocodeBlock)(LocationModel* model);
typedef void(^FinishLocalBlock)(CLLocationCoordinate2D coord);

@interface LocationService : NSObject

+ (void)getCoordWithBlock:(FinishLocalBlock)block; //获取当前经纬度

+ (void)getAdressWithBlock:(FinishGeocodeBlock)block; //获取当前经纬度和详细地址

@end

@interface LocationModel : NSObject

@property(nonatomic,copy)NSString* address;
@property(nonatomic,copy)NSString* streetNumber;
@property(nonatomic,copy)NSString* streetName;
@property(nonatomic,copy)NSString* district;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* province;

@property(nonatomic,assign)CLLocationCoordinate2D coord;

@end