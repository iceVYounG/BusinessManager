//
//  CloseliProductInfo.h
//  LeCamPurchase
//
//  Created by jinkelei on 13-1-30.
//  Copyright (c) 2013年 ArcSoft. All rights reserved.
//

/**
 *  Specifies a pay service type
 */
typedef NS_ENUM(NSUInteger,KServiceType) {
    /**
     *  Default type.
     */
    KServiceTypeDefault = 0,
    /**
     *  Trial Type.
     */
    KServiceTypeLight,
    /**
     *  Standard service type.
     */
    KServiceTypeStandard,
    /**
     *  Premium service type.
     */
    KServiceTypePremium
};
/**
 *  A CloseliProductInfo object is that specfies the service type that we provide.
 */
@interface CloseliProductInfo : NSObject

///Product ID in app store.
@property(nonatomic,  copy)NSString         *productId;
///Product type in app store
@property(nonatomic,assign)unsigned int     productType;
///Service id which specifies a service type. e.g:1:to use,Can't buy; 2 - 5:normal
@property(nonatomic,assign)unsigned int     serviceId;
///Service time can be used.(Month)
@property(nonatomic,  copy)NSString         *serviceTime;
///Video storage time.(day)
@property(nonatomic,assign)unsigned int     dvrDays;
///service price.
@property(nonatomic,assign)double           price;
///service status,0,1 enable,-1 disable.
@property(nonatomic,assign)int              statue;
///trail:1  standard month:2  standard year:3 premium month:4  premium year:5, used to sort service.
@property(nonatomic,assign)int              order;
///coupon code.
@property(nonatomic,  copy)NSString         *couponCode1;
///coupon code.
@property(nonatomic,  copy)NSString         *couponCode2;
///The service name of the service id. Used for displaying.
@property(nonatomic,  copy)NSString         *serviceName;
///The service type name. Used for displaying.
@property(nonatomic,  copy)NSString         *serviceType;
///price measurement. eg:USD/RMB.
@property(nonatomic,  copy)NSString         *currency;
///How long(hour) can save up video clips.
@property(nonatomic,assign)NSInteger        clipsTime;
///The orderItem is not useful, just pass back after the purchase is completed.
@property(nonatomic, copy)NSString          *orderItem;

/**
 *  Get price string
 *
 *  @return a string which describe the price.
 */
-(NSString *)getPriceString;

/**
 *  Get service type
 *
 *  @return a KServiceType value.
 */
- (KServiceType)getServiceType;
@end











