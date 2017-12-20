//
//  WeiZhanModel.h
//  BusinessManager
//
//  Created by Niuyp on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "BaseModel.h"
#import "JsonArray.h"

@interface WeiZhanModel : BaseModel
#define HZImageH 151
#define HZImageGap 3

NSString* DefaultStr();

@end


@interface PhotoImageModel : BaseModel

@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *imageName;


@end


@interface MyWeiZhans : BaseModel

@property (nonatomic, strong) NSArray *data;
@end

#pragma mark - 我的微站model
@interface MyWeiZhanModel : BaseModel

@property (nonatomic, copy) NSString *auditId;
@property (nonatomic, copy) NSString *auditStatus;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *dyStoreId;
@property (nonatomic, copy) NSString *frontPageUrl; //预览图
@property (nonatomic, copy) NSString *qrcImagePath; //二维码图
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shortAddress;
@property (nonatomic, copy) NSString *templateNo;
@property (nonatomic, copy) NSString *shortIdentification;
@property (nonatomic, copy) NSString *updateStatus;
@property (nonatomic, assign) NSInteger storeId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger source;
@property (nonatomic, assign) NSInteger wzId;

@end

#pragma mark - 二级界面模块model
@class TemplateData;
@interface SearPartData : BaseModel

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) TemplateData *temPlate;

@end



@interface TemplateData : BaseModel

@property (nonatomic, copy) NSString *auditId;
@property (nonatomic, copy) NSString *auditStatus;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *dyStoreId;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shortAddress;
@property (nonatomic, copy) NSString *shortIdentification;
@property (nonatomic, copy) NSString *templateNo;
@property (nonatomic, copy) NSString *updateStatus;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger source;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger storeId;
@end

@class TemplateModelData;
@interface PartModel : BaseModel

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *dateType;
@property (nonatomic, copy) NSString *sortNum;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *templateModelname;
@property (nonatomic, copy) NSString *templateModelnameCode;
@property (nonatomic, copy) NSString *templateNo;
@property (nonatomic, strong) TemplateModelData *templateModelnameDate;
@property (nonatomic, assign) NSInteger id;


#pragma mark - 自定义
@property (nonatomic, copy) NSString *HB_hidenAtIndex;
@end



@interface TemplateModelData : BaseModel

@property (nonatomic, strong) NSArray *date;

@property(nonatomic,strong)NSString *other;
@property(nonatomic,strong)NSString *customerName;
@property(nonatomic,strong)NSString *customerMoble;

@end



@interface TemplateModel : NSObject

@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *imgPath;//图片路径
@property (nonatomic, copy) NSString *type;//餐饮模块代表电话
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *shopPrice;
@property (nonatomic, copy) NSString *outPath;
@property (nonatomic, copy) NSString *busline;//公交、地铁线路
@property (nonatomic, copy) NSString *address;//地址
@property (nonatomic, copy) NSString *bdLong;//纬度
@property (nonatomic, copy) NSString *bdLat;//经度
@property (nonatomic, copy) NSString *webPath;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property(nonatomic,strong) NSMutableArray* images;
@property(nonatomic,strong) NSMutableArray *tabs;
@property(nonatomic,strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic,strong) NSString *floorCode;
@property (nonatomic,strong)NSString *floorName;
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,strong)NSString *preCode;
@property (nonatomic,strong)NSString *shopName;
@property (nonatomic,strong)NSString *shopPhone;
@property (nonatomic,strong)NSString *real;


#pragma mark - 自定义

@property(nonatomic,strong) NSString* shopFileCellH;


@end


@interface FlowerAddressModel : BaseModel
@property (nonatomic, strong) TemplateModel *address;//地址
@property (nonatomic, strong) NSString *name;
@property (nonatomic,strong)NSString *shopPhone;
@end


//调查问卷独立Model

@class QuestionDateModel;
@interface QuestionListModel : BaseModel

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *dateType;
@property (nonatomic, copy) NSString *sortNum;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *templateModelname;
@property (nonatomic, copy) NSString *templateModelnameCode;
@property (nonatomic, copy) NSString *templateNo;
@property (nonatomic, strong) QuestionDateModel *templateModelnameDate;
@property (nonatomic, assign) NSInteger id;
@end



@interface QuestionDateModel : BaseModel

@property (nonatomic, strong) NSArray *date;
@end

@interface QuestionOptionsModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property(nonatomic,strong) NSMutableArray *tabs;
@property(nonatomic,strong) NSString *title;

@end


@interface ImagePathModel : NSObject

@property (nonatomic, copy) NSString *imagePath;
@end

#pragma mark - 要上传的参数model
@interface PramsArryModel : BaseModel

@property (nonatomic, strong) NSArray* prams;

@end


@interface ImagePath : BaseModel
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *id;
@end

@interface ImageUpLoadBackModel : BaseModel

@property (nonatomic, strong) ImagePath *data;

@end

@interface ADImageModel : BaseModel
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) BOOL isEdit;
@end

@interface ECProductModel : BaseModel
@property (nonatomic,strong)NSString *productId;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *shortName;
@property (nonatomic,strong)NSString *webPath;
@property (nonatomic,strong)NSString *marketPrice;
@property (nonatomic,strong)NSString *shopPrice;
@property (nonatomic,strong)NSString *itemType;
@end
@interface HZImageModel : BaseModel
@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, strong)NSMutableArray *names;

@end

@interface HZIconViewFrame : NSObject
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, assign)CGFloat cellHeight;
@end


@interface YuyueRecordModel : BaseModel

@property (nonatomic, strong) NSArray *data;
@end

@interface YueyueDataModel : NSObject
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *dateTime;
@property (nonatomic, strong)NSString *templateModelnameCode;
@property (nonatomic, strong)NSString *yuyueId;
@end


@interface YuyueDeatailModel : BaseModel
@property (nonatomic, strong) NSArray *data;
@end

@interface YueyueDeatailData : NSObject
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)NSString *key;
@end


typedef NS_ENUM(NSInteger, ModelSectionType) {
    
    ModelSectionTypeNomal,
    ModelSectionTypeFooter
};
@interface ModelSection : NSObject

@property (nonatomic, assign) ModelSectionType type;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong)TemplateModel *model;
@property (nonatomic, copy)  NSString *content;

@end


@interface ShenHeModel : BaseModel

@property (nonatomic, strong) NSArray *data;
@end

@interface ShenHeDataModel : NSObject
@property (nonatomic, strong)NSString *auditContent;
@property (nonatomic, strong)NSString *auditStatus;
@end

//联想检索功能
@interface MapResultModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (assign, nonatomic) int epoitype;
//@property (nonatomic) CLLocationCoordinate2D pt;

@end

@interface WZ_FloorModel_item : NSObject

@property (nonatomic, strong) NSString *ID;

@end

//--------楼层Model _templateModelnameDate -----------//
@interface WZ_FloorModel_templateModelnameDate : NSObject

@property (nonatomic, strong) NSString *floorCode;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) NSString *preCode;
@property (nonatomic, strong) NSMutableArray *items;

@end

/*
 *字段释义：
 *floorCode：楼层编码，不可重复
 *preCode：上一个楼层编码（若该楼层排序为第一，preCode传0，否则传上一楼层的楼层编码）
 *floorName：楼层名称
 *items：楼层包涵的商品（只需ID即可）
 *【注】：模块ID字段，新增和编辑传0，删除传-1
 */

//----------楼层Model------------//
@interface WZ_FloorModel : BaseModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *sortNum;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *templateModelname;
@property (nonatomic, strong) NSString *templateModelnameCode;
@property (nonatomic, strong) WZ_FloorModel_templateModelnameDate *templateModelnameDate;
@property (nonatomic, strong) NSString *templateNo;

@end

//--------楼层商品Model ----------//
@interface WZ_FloorGooodsModel : BaseModel

@property (nonatomic, strong) NSMutableArray *date;

@end

/*
 *字段释义：
 *id：商品ID，新增传0
 *content：商品详情
 *imgPath：商品封面图片（多张图片，只可取一张，其他图片可用HTML标签拼接至content字段末尾）
 *name：商品名称
 *price：商品价格（单位分）
 */

@interface WZ_FloorGooodsItemModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *real;
@property (nonatomic, strong) NSString *id;
@end






