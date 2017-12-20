//
//  Host.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/20.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#ifndef Host_h
#define Host_h

//API_关键字 宏定义
//#define VIPCARD_Server   @"112.4.27.8" //VIPCard 测试地址
//#define VIP_testRoot  @"/bfsh-ws_inter/"
#define VIPCARD_Server   @"183.207.110.93:8085" //VIPCard 测试地址
#define VIP_testRoot  @"/bfsh-ws-inter/"
#define VIP_AppendRootUrl(str) [VIP_testRoot stringByAppendingString:str]
//---------------∆∆∆∆测试地址--------------
#define Server   @"183.207.110.93:8085"
#define URL_Root @"/bfsh-ws-inter/"

//#define Server   @"112.4.27.8"
//#define URL_Root @"/bfsh-ws_inter/"

#define AppendRootUrl(str) [URL_Root stringByAppendingString:str]

//-------------登录注册模块------------//

//#define API_LoginHost     AppendRootUrl(@"login.chtml") //登录

//登录改为测试地址以测试会员管理
#define API_LoginHost     VIP_AppendRootUrl(@"login.chtml")         //登录
#define API_RegisterHost  AppendRootUrl(@"register.chtml")          //注册
#define API_SmsCodeHost   AppendRootUrl(@"getSmsCode.chtml")        //获取验证码
#define API_retrievePwdHost AppendRootUrl(@"retrievePwd.chtml")     //重置密码

#define API_aboutpProtocol @"http://183.207.110.93:8085/bfsh-ws-inter/static/html/FAQ/about-protocol.html"
//#define API_aboutpProtocol AppendRootUrl(@"static/html/FAQ/about-protocol.html")
//-------------登录注册模块------------//



//------------我的微站模块-----------------//
#define API_Storecenter  @"storecenter/template.chtml" //电商已创建模板查询接口
#define API_Storecenter_TemplateSearch @"storecenter/templateSearch.chtml"  // 商户通用模板数据获取接口
#define API_DefaultTemplate  @"storecenter/getDefaultDate.chtml"
//鲜花店默认数据
#define API_QuickRegistHost @"fastRegister.chtml"//快速注册
#define API_ImageUpload  @"storecenter/imgUpload.chtml" // 图片上传接口  
#define API_HistoryImageUpload  @"storecenter/historyImgUpload.chtml"//花店图片上传
#define API_TemplateSave  @"storecenter/templateSave.chtml"//商户模板模块数据新增|修改接口
#define API_storeTemplateSave  @"storecenter/storeTemplateSave.chtml" //模板保存
#define API_storeTemplateDelete  @"storecenter/storeTemplateDel.chtml"   
#define API_appointSearch @"storecenter/appointSearch.chtml"//预约看房
#define API_appointRecordDeatail @"storecenter/appointDetailSearch.chtml"//预约记录详情
#define API_ECProductGet @"storecenter/productsList.chtml"//电商商品
#define API_TijiaoSH @"storecenter/templateAuditSave.chtml"//提交审核
#define API_shenHeJL @"storecenter/templateAuditList.chtml"//审核记录
#define API_WZ_FloorGoodsInfo @"storecenter/floorGoodsInfo.chtml"///楼层商品详情查询
#define API_WZ_FloorGoodsEdit @"storecenter/floorGoodsEdit.chtml"///楼层商品添加
#define API_HistoryImageGet @"storecenter/historyList.chtml"//花店历史图片获取
#define API_DeleteImage @"storecenter/historyImgDel.chtml"//删除花店banner图片

//----------------抽奖活动----------------------//
#define API_LuckyDraw_RechargeMoney  AppendRootUrl(@"storecenter/getHeDouBalances.chtml")   //现金红包余额查询
#define API_LuckyDraw_RechargeList  AppendRootUrl(@"storecenter/hedouList.chtml") //现金红包充值列表
#define API_LuckyDraw_UserRechargeImmediate  AppendRootUrl(@"storecenter/hedouRechareForActive.chtml") //现金红包充值(商户自充）

//#define API_LuckDraw_ActivityList @"/bfsh-ws_inter/storecenter/activeList.chtml" // 抽奖活动管理列表
//#define API_LuckDraw_ActivityInfo @"/bfsh-ws_inter/storecenter/activeInfo.chtml" // 抽奖活动详情
//#define API_LuckDraw_Activitysave @"/bfsh-ws_inter/storecenter/activeSave.chtml"// 保存抽奖活动
//#define API_LuckDraw_ActivityDelete @"/bfsh-ws_inter/storecenter/activeDel.chtml" // 删除活动
//#define API_LuckDraw_ActivityPrizeDelete @"/bfsh-ws_inter/storecenter/prizeDel.chtml"// 删除活动奖品

#define API_LuckDraw_ActivityList AppendRootUrl (@"storecenter/activeList.chtml") // 抽奖活动管理列表
#define API_LuckDraw_ActivityInfo AppendRootUrl (@"storecenter/activeInfo.chtml") // 抽奖活动详情
#define API_LuckDraw_Activitysave AppendRootUrl (@"storecenter/activeSave.chtml")// 保存抽奖活动
#define API_LuckDraw_ActivityDelete AppendRootUrl (@"storecenter/activeDel.chtml") // 删除活动
#define API_LuckDraw_ActivityPrizeDelete AppendRootUrl (@"storecenter/prizeDel.chtml") // 删除活动奖品
//----------------会员卡管理----------------------///
#define API_VipCardManger_VipCardList  VIP_AppendRootUrl(@"storecenter/memberCardList.chtml") //电子会员卡列表接口
#define API_VipCardManger_memberCardLevelList  VIP_AppendRootUrl(@"storecenter/memberCardLevelList.chtml") //会员卡级别列表
#define API_VipCardManger_VipCardDetail  VIP_AppendRootUrl(@"storecenter/memberCardInfo.chtml") //会员卡详情
#define API_VipCardManger_AddCardLevel  VIP_AppendRootUrl(@"storecenter/memberCardLevelSave.chtml")//添加会员等级
#define API_VipCardManger_DeleteVipCard  VIP_AppendRootUrl(@"storecenter/MemberCardDel.chtml")//删除会员卡
#define API_VipCardManger_SaveVipCard  VIP_AppendRootUrl(@"storecenter/memberCardSave.chtml")//保存会员卡
#define API_VipCardManger_SaveVipCardLevel VIP_AppendRootUrl(@"/storecenter/memberCardLevelSave.chtml")//保存会员卡级别
#define API_VipCardManger_recharge  VIP_AppendRootUrl(@"storecenter/vipcard/recharge.chtml")//储值卡充值
#define API_VipCardManger_rechargeList  VIP_AppendRootUrl(@"storecenter/vipcard/rechargeList.chtml")//储值卡充值列表
#define API_VipCardManger_VIPList  VIP_AppendRootUrl(@"storecenter/vipcard/list.chtml")//会员列表数据获取
#define API_VipCardManger_view  VIP_AppendRootUrl(@"storecenter/vipcard/view.chtml")//会员详情信息
#define API_VipCardManger_VIPUserDelete  VIP_AppendRootUrl(@"storecenter/vipcard/delete.chtml")//删除会员
#define API_VipCardManger_MemberCardSave  VIP_AppendRootUrl(@"storecenter/memberCardSave.chtml")//创建电子会员卡/保存
#define API_VipCardManger_Release  VIP_AppendRootUrl(@"storecenter/vipcard/release.chtml")//发放会员卡

//------------彩信短信推送--------------------------//

#define API_MessagePush_msgPushList  AppendRootUrl(@"storecenter/smsList.chtml")  //推送列表
#define API_MPBuyMessage_leaveMsgNum  AppendRootUrl(@"storecenter/leaveMsgNum.chtml") //彩信短信剩余条数
#define API_MPBuyNotes_SMSForBuyList  AppendRootUrl(@"storecenter/SMSForBuyList.chtml") //彩信短信购买记录
#define API_MessagePush_smsSave  AppendRootUrl(@"storecenter/smsSave.chtml") //新增短彩信推送
#define API_MessagePush_smsSend  AppendRootUrl(@"storecenter/smsSend.chtml") //发送
#define API_MessagePush_smsView  AppendRootUrl(@"storecenter/smsView.chtml") //查看详情
#define API_MessagePush_smsDelete  AppendRootUrl(@"storecenter/smsDelete.chtml")  //删除SMS
#define API_MessagePush_buySMSPackage AppendRootUrl(@"storecenter/buySMSPackage.chtml") //购买短信


//------------数据统计---------

#define API_DataCount              AppendRootUrl(@"storecenter/dataStatisticsIndex.chtml")//数据统计


#define API_CheckBill              AppendRootUrl(@"storecenter/bill/list.chtml")//对账单
#define API_CheckBillDeatail            AppendRootUrl(@"storecenter/bill/query.chtml")//对账单详情
#define API_flowCount              AppendRootUrl(@"storecenter/trafficAnalysis.chtml")//流量统计
#define API_ConfirmCount              AppendRootUrl(@"storecenter/verifystatistic/list.chtml")//验证统计
#define API_ConfirmCountDeatail              AppendRootUrl(@"storecenter/verifystatistic/query.chtml")//验证统计详情
#define API_ActiveCount             AppendRootUrl(@"storecenter/activeStatisticsList.chtml")//活动统计
#define API_ActiveCountDeatail              AppendRootUrl(@"storecenter/activeStatisticsInfo.chtml")//活动统计详情
//------------验证模块-----------------//
#define API_Scan                    AppendRootUrl(@"storecenter/vipcard/search.chtml")
#define API_VerifyList           AppendRootUrl(@"storecenter/verifystatistic/verifyList.chtml")
//#define API_Consume                AppendRootUrl(@"storecenter/vipcard/consume.chtml")
#define API_SendConsumeCode        AppendRootUrl(@"storecenter/sendConsumeCode.chtml")
#define API_VerifyConsumeCode        AppendRootUrl(@"storecenter/verifyConsumeCode.chtml")

//-------------我的设置模块------------//

#define API_CHANGEPASS        AppendRootUrl(@"storecenter/pwdEdit.chtml")                //修改密码

//-------------我的设置模块------------//

//手机看店
#define API_userBindingSearch       AppendRootUrl(@"storecenter/remoteShopView/userBindingSearch.chtml")
#define API_userBinding       AppendRootUrl(@"storecenter/remoteShopView/userBinding.chtml")

#define API_getSeqno       AppendRootUrl(@"/getSeqno.chtml")
#define API_fastRegister       AppendRootUrl(@"/fastRegister.chtml")
#define API_updateStoreInfo       AppendRootUrl(@"storecenter/updateStoreInfo.chtml")

//后台监听定时器
#define NOTIFICATION_RESIGN_ACTIVE              @"appResignActive"
#define NOTIFICATION_BECOME_ACTIVE              @"appBecomeActive"



#endif /* Host_h */
