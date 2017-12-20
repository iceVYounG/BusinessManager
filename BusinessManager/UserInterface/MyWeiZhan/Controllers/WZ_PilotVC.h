//
//  WZ_PilotVC.h
//  BusinessManager
//
//  Created by Niuyp on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "WeiZhanBaseController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入联想搜索的头文件

@class PartModel;

typedef void(^PiolitBlock)(PartModel *model, BOOL isNew);

@interface WZ_PilotVC : WeiZhanBaseController <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    UIView* _naviBarView;
    BMKLocationService* _locService; //定位
    CLLocationCoordinate2D _userCoord; //当前位置
    
    BMKGeoCodeSearch* _geoCoder;   //编码
    BMKReverseGeoCodeOption* reverseOption;
    int _currentPage;
}

@property (nonatomic, copy) NSString *type;


@property (nonatomic, strong) PartModel *model;

@property (nonatomic, copy) PiolitBlock block;

- (instancetype)initWithBlock:(PiolitBlock)block;

@end
