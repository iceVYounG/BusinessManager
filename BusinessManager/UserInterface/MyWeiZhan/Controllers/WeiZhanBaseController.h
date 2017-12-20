//
//  WeiZhanBaseController.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/22.
//  Copyright © 2016年 cmcc. All rights reserved.
//

//-----templateNo-----------//
#define Tongyong  @"ws_base"    //通用模块
#define DianShang @"ws001"      //电商模版
#define SiSDian   @"ws002"      //4S店模版
#define CanYin    @"ws003"      //餐饮模版
#define JiaZhuang @"ws004"      //家装模板
#define FangChan  @"ws005"      //房产模板
#define FlowerShop @"ws_flower"  //花店模板
#define FruitShop @"ws_fruit"    //水果店模板
#define BreadShop @"ws_bread"    //面包店模板
//-----电商模板----------//
#define BannerPic     @"dpdt"           //电商模版
#define LiaoJWM       @"ljwm"           //了解我们
#define WeiNTJ        @"wntj"           //为您推荐
#define LianXWM       @"lxwm"           //联系我们
#define WeiNDH        @"wndh"           //为您导航
#define LunBT         @"lbt"            //轮播图
#define LouCY         @"lc1"            //楼层一
#define LouCE         @"lc2"            //楼层二
#define QiangHB       @"ljq"            //抢红包
#define DaZP          @"dzp"            //大转盘
#define GuaGK         @"ggk"            //刮刮卡
#define ShopName      @"shopName"       //店铺名称
#define ShopDetail    @"storeProfile"   //商户介绍
#define ShopService   @"storeServices"  //商户服务信息
#define HotFood       @"hotFood"        //热菜推荐
#define YiJFK         @"yjfk"           //意见反馈
#define FloorCode      @"floor"         //楼层

//-----4S模板----------//
#define HotCarTuijian      @"hotCar"       //热车推荐
#define DiaochaWJ          @"dcwj"       //调查问卷
#define YuyueSJ            @"yysj"       //预约试驾
#define YuyueBY            @"yyby"       //预约保养

//-----餐饮模板----------//
#define FoodMenu      @"foodMenu"       //菜单
#define About         @"about"          //关于我们
#define Activity      @"activity"     //活动信息
                                        //为您导航 同电商
#define KeysArry @[@"bdLong",@"bdLat"]
#define HB_KeysArry @[QiangHB,DaZP,GuaGK]


//----房产模板--------
#define LouPJJ        @"lpjj"           //楼盘简介
#define HuXXS         @"hxxs"           //户型欣赏
#define WeNDH         @"wndh"           //为你导航
#define CuXHD         @"cxhd"           //促销活动
#define YuYKF         @"yykf"           //预约看房
#define LianXWM       @"lxwm"           //联系我们


//------家装------
#define ZhuangXBJ     @"zxbj"           //装修报价
#define MoreCase      @"gdal"           //更多案例
#define JingDianCase  @"jdal"          //经典案例
#define NowYuYue      @"msyy"          //马上预约
#define YuYueZX       @"yyzx"          //预约装修
#import "BaseController.h"

//---------花店，水果店，面包店--------
#define DianPBanner  @"shopBanner"   //banner图
#define DianPMessage  @"shopInfo"   //店铺信息
#define ReMTJ  @"rmtj"              //热门推荐
#define LOUC @"floor"               //楼层

//--------照片选择裁剪 -----------
#import "JMPickCollectView.h"
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "CLImageEditor.h"


typedef void(^SelectedOrTailorImage)(NSData *imageData);
typedef void(^SelectedOrBannerImage)(UIImage *image);
typedef void(^SelectedMutilImagesBlock)(NSMutableArray *imageArray);

@interface WeiZhanBaseController : BaseController
@property (nonatomic,strong)NSString *isFlower;
//临时微站storeId
//@property (nonatomic, strong) NSString *tempStoreId;
@property (nonatomic, strong) NSString *targetStoreId;
/*返回图片的data，数据已压缩*/
@property (nonatomic, copy) SelectedOrTailorImage selectedOrTailorImage;
@property (nonatomic, copy) SelectedOrBannerImage selectedOrBannerImage;
/*返回多选的图片数组*/
@property (nonatomic ,copy) SelectedMutilImagesBlock selectedMutilImagesBlock;
#pragma mark - 保存模块
-(void)saveTemplte:(NSMutableArray*)datas succeed:(void (^)(id responseObject))succeed error:(void (^)(NSError* error))errored;

#pragma mark - 保存模板
-(void)saveTemple:(NSString*)templeNo andshopName:(NSString *)shopName;


-(void)quickRegister:(NSString *)linkePhone smsCode:(NSString *)smscode store:(NSString *)storeName withHongBao:(BOOL)isHongBao withTempNo:(NSString *)str;
-(void)updateStoreInforRequest:(NSString *)sourceId targetId:(NSString *)targetId withTempNo:(NSString *)str withHongBao:(BOOL)ishongBao;

-(void)requestGetSeqno;

/**
 * @ 最大图片体积限制 UIImage --> UIImage
 * @ param image: 要裁剪的图片
 * @ return: 图片
 */
 
- (UIImage *)getMaxImageDataLimitedWithImage:(UIImage *)image;
/**
 * @ 最大图片体积限制 UIImage --> NSData
 * @ param image: 要裁剪的图片
 * @ return: 图片Data
 */

- (NSData *)transformImageToDataLimited:(UIImage *)image;
/**
 * @ 最大图片体积限制 NSData --> NSData
 * @ param imageData: 要裁剪的图片data
 * @ return: 图片data;
 */
- (NSData *)getMaxImageDataLimitedWithData:(NSData *)imageData;

#pragma mark - 弹出actionSheet 拍照，相册(单选) 具有剪裁功能
/**
 * @ param imageWidth: 剪裁图片-宽度
 * @ param imageHeight: 剪裁图片-高度
 */

- (void)showImagePickerOrPhotoCamera:(CGFloat)imageWidth andHeight:(CGFloat)imageHeight;

#pragma mark - 弹出actionSheet 拍照，相册(多选) 没有剪裁功能 (可以使用下面的代码剪裁)
/**
 * @ param imageWidth: 剪裁图片-宽度
 * @ param imageHeight: 剪裁图片-高度
 */

- (void)showCameraOrMutilPhotoPicker:(SelectedMutilImagesBlock)block;

/**
 * @ centerBool 截取部分图像是否是中心截取
 * @ cutCGRect 需剪裁的尺寸
 **/
-(UIImage*)getSubImage:(UIImage *)image cutCGRect:(CGRect)cutCGRect centerBool:(BOOL)centerBool;

/**
 * @ 宽高 1 : 1 剪裁图片（根据图片的尺寸来，高 > 宽 取宽做尺寸，反之...）
 * @ centerBool 是否中心裁剪 是:从中心剪裁  否:从(0，0)原点剪裁
 *
 */
-(UIImage*)getSubImage:(UIImage *)image centerBool:(BOOL)centerBool;

/**
 * @ centerBool 是否中心裁剪 是:从中心剪裁  否:从(0，0)原点剪裁
 * @cutRatio 剪裁的宽高比
 */
-(UIImage*)getSubImage:(UIImage *)image cutRatio:(CGFloat)cutRatio centerBool:(BOOL)centerBool;

@end
