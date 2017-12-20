//
//  CloseliError.h
//  CloseliSDK
//
//  Created by yf6190 on 9/12/14.
//  Copyright (c) 2014 arcsoft. All rights reserved.
//


#ifndef CloseliSDK_CloseliError_h
#define CloseliSDK_CloseliError_h

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CloseliError_E) {
/**
    Error code defined by ESD
     NVALID_PARAM_ERROR_CODE = "1000";   //参数异常
     JSONPARSER_ERROR_CODE = "1001";  //参数异常
     DATAACCESSEXCEPTION_ERROR_CODE = "1002";  // 数据库处理异常
     HTTPHOSTCONNECTEXCEPTION_ERROR_CODE = "1003";  // Http 请求异常
     NULLPOINTEREXCEPTION_ERROR_CODE = "1004";  // 空指针异常
     OTHEREXCEPTION_ERROR_CODE = "1005";  //其他异常，未捕捉到
     PAYMENTEXCEPTION_ERROR_CODE = "1006";  // webPurchase 异常
     NUMBERFORMATEXCEPTION = "1007"; // 数据格式异常
     ACTIONFLAGEXCEPTION_ERROR_CODE = "1008";  //接口标记异常，已经弃用
     DEVICELIMITEXCEPTION_ERROR_CODE = "1009";  // 设备对应服务的连接个数异常
     PAYPALEXCEPTION_ERROR_CODE = "1100";  // paypal 支付异常
     PAYSERVICEALLOWEXCEPTION_ERROR_CODE = "1101"; // 购买状态异常，不符合购买逻辑
     PAYMENTPRICEEXCEPTION_ERROR_CODE = "1102";  // 价格异常
     PAYPALPAYMENTEXCEPTION_ERROR_CODE = "1103";  // paypal 支付异常
     CREDITCARDSNOSUPPORTEXCEPTION_ERROR_CODE = "1104";  // 信用卡类型不支持
     AUTOPAYMENTEXCEPTION_ERROR_CODE = "1105"; // 开通paypal自动扣款异常
     CANCELAUTOEXCEPTION_ERROR_CODE = "1106";  // 取消paypal 自动扣款异常
     DEVICEMAKETRYEXCEPTION_ERROR_CODE = "1107";
     APPCHECKOUTEXCEPTION_ERROR_CODE = "1108";
     OPENAUTOPAYMENTEXCEPTION_ERROR_CODE = "1109";
     NOTIFICATIONEXCEPTION_ERROR_CODE = "1110";
     DEVICETRANSFERRINGEXCEPTION_ERROR_CODE = "1111";
     DEVICESELFEXCEPTION_ERROR_CODE = "1112";
     DEVICEOTHEREXCEPTION_ERROR_CODE = "1113";
     LNAGCODEMISSINGEXCEPTION_ERROR_CODE = "1114";
     UPDATEDATAECXEPTION_ERROR_CODE = "1115";
     DEVICEVERIFYEXCEPTINO_ERROR_CODE = "1116";
     USEREMAILCHANGEEXCEPTION_ERROR_CODE = "1117";
     UPDATEFULLRELAYCHANNCELNAME_EXCEPTION_CODE = "1118";
     DEVICESHAREID_EXCEPTION_CODE = "1119";
     USEREMAILERROR_CODE = "1120";
     DEVICESHAREID_ERROR_CODE = "1121";
     ACTIVATAEDCODE_ERROR_CODE = "1122";
     ALIPAYEXCEPTION_ERROR_CODE = "1123";
     ALIPAYPLATEXCEPTION_ERROR_CODE = "1124";
     STATIONREGISTEREXCEPTION_ERROR_CODE = "1125";
     INVALID_SIG_ERROR_CODE = "1126";
     INVALID_CLIENTID_ERROR_CODE = "1127";
     INVALID_UNREGISTERTYPE_ERROR_CODE = "1128";
     INVALID_MODELID_SUPPORTSERVICE_ERROR_CODE = "1129";
     
     //Face Recognize error code
     FACE_INVALID_PERSIONID = "1130";
     FACE_INVALID_FACENAME = "1131";
     PROFILEINVALIDATEPARAMETER_ERROR_CODE = "2001";
     PROFILESCHEMAVALIDATE_ERROR_CODE = "2002";
     PROFILEPATHLEVLE_ERROR_CODE = "2003";
     PROFILEPATHNOELEMENT_ERROR_CODE = "2004";
     PROFILEPATH_ERROR_CODE = "2005";
     PROFILEPARAME_SCHEDULEVALUE_ERROR_CODE = "2006";
     PROFILEALREADYINIT_ERROR_CODE = "2007";
     PROFILE_NOCURRENTSETTINGL_ERROR_CODE = "2008";
     PROFILE_INVALIDSUBREQUESTID_ERROR_CODE="2009";
     PROFILE_SENDFULLRELAY_ERROR_CODE="2011";
     PROFILE_SENDCAMERA_ERROR_CODE="2012";
     PROFILE_INVALIDSELFDEFINE_ERROR_CODE="2013";
     USERSETTINGSINVALIDATEPARAMETER_ERROR_CODE = "2010";
     
     //myfox oem error
     MYFOX_TOKEN_ERROR="4000";
     MYFOX_SITEID_ERROR="4001";
     MYFOX_DEVICEID_ERROR="4002";
     
     MYFOX_BACKUP_SSID_ERROR="4003";
     MYFOX_BACKUP_SECURITY_ERROR="4004";
     MYFOX_BACKUP_PASSWORD_ERROR="4005";
     
     MYFOX_SHUTTERSTATUS_ERROR="4006";
     
     MYFOX_SERVICELEVEL_NULL_ERROR="4007";
     MYFOX_SERVICELEVEL_NOTMATCH_ERROR="4008";
     
     MYFOX_INTERFACE_RESULT_ERROR="4100";
     MYFOX_INTERFACE_CAMERAINSTALL_ERROR="4101";
     MYFOX_INTERFACE_GETCAMERADETAIL_ERROR="4102";
     MYFOX_INTERFACE_GETBACKUP_ERROR="4103";
     MYFOX_INTERFACE_GETSERVICELEVEL_ERROR="4104";
 */
    CloseliError_Esd,
/**
    Error code defined by cloud.
    10000	 Unknown system error, recommend try again.	 未知错误，建议重试
    10001	 service_exception	 数据库异常等
    10002	 username_blank	 用户名为空
    10003	 username_not_found	 用户名不存在（其实是email地址不存在）
    10004	 username_invalid	 用户无效(含有非法字符或长度不是2-50个字符)
    10005	 password_invalid	 密码无效(为空或与注册的不符)
    10006	 user_locked	 用户账号被锁定
    10007	 user_disabled	 用户账号不可用
    10008	 account_expired	 用户账号过期
    10009	 credentials_expired	 用户密码失效
    10010	 invalid_sigature	 无效的签名
    10011	 account_unactivated	 账户未激活
    11001	 system_error	 系统错误
    11003	 password_blank	 密码为空
    11004	 email_blank	 email 为空
    11008	 password_too_short	 密码少于规定的字符（6个字符）
    11009	 password_too_long	 密码多于规定的字符（26个字符）
    11010	 password_invalid	 密码含有不合法字符
    11011	 email_invalid	 邮箱含有不合法字符
    11012	 two_different_password	 确认密码和密码不相同
    11013	 email_registered	 该邮箱已经注册
    11204	 check_code_invalid	 无效的验证码
    11205	 email_not_exist	 输入的邮箱不存在
    11206	 active_code_blank	 激活码为空
    11208	 active_code_expired	 激活码过期
    11209	 active_code_invalid	 激活码无效(和数据库中的激活码不一致)
    11210	 verify_code_incorrect	 校验码错误
    11214	 user_id_blank	 user_id 为空
    11215	 user_id_not_exist	 user_id 不存在
    11216	 user_id_invalid	 无效的 user_id
    11217	 user_already_active	 该用户已被激活
    11218	 user_status_blank	 用户状态为空
    11219	 user_status_invalid	 无效的用户状态
    11220	 old_password_blank	 旧密码为空
    11221	 new_password_blank	 新密码为空
    11222	 old_password_invalid	 旧密码无效
    11223	 new_password_too_short	 新密码太短（少于6个字符）
    11224	 new_password_too_long	 新密码太长（大于26个字符）
    11225	 new_password_invalid	 新密码含有不合法字符
    11226	 forbid_send_activemail	 禁止发送激活邮件(用户状态不是未激活状态时)
    11227	 no_need_to_activate	 用户状态正常，不需要激活
    11228	 forbid_reset_password	 用户状态未激活，禁止重设密码
    11400	 device_id_blank	 deviceId为空
    11401	 device_id_invalid	 deviceId无效（java regexp: ^[a-zA-Z0-9\\(\\)_\\-\\./]{1,50}$）
    11402	 device_name_invalid	 deviceName无效（同上）
    11403	 device_id_exists	 deviceId在已经存在（注册时发生）
    11404	 device_id_not_found	 deviceId不存在（登录时发生）
    11407	 device_add_status_invalid	 device add接口返回参数status无效
    12001	 product_key_blank	 productKey为空
    12002	 product_key_not_exist	 productKey不存在
    12003	 username_or_password_incrrect	 用户名或密码错误
    15201	 share to sns failed	 share to sns failed
    15202	 from is empty	 from is empty
    15203	 title is empty	 title is empty
    15204	 desc is empty	 desc is empty
    15205	 target is empty	 target is empty
    15206	 privacy is empty	 privacy is empty
    15207	 privacy is invalid	 privacy is invalid
    15208	 shareId is empty	 shareId is empty
    15209	 shareId is not exist	 shareId is not exist
    15210	 target is invalid	 target is invalid
    15211	 file type is invalid	 file type is invalid
    15212	 title is invalid	 title is invalid
    15213	 get AccessToken Error	 get AccessToken Error
    15214	 Youtube refreshToken、accessToken is invalid or revoked or invalid_grant	 Youtube refreshToken、accessToken is invalid or revoked or invalid_grant
    15215	 file dosen't exist	 file dosen't exist
    15216	 sns access denied when user click "cancel"	 sns access denied when user click "cancel"
    16001	 invalid_request	 无效的请求
    16002	 invalid_client	 无效的client（client_id，client_secret不存在或不匹配等）
    16003	 invalid_grant	 无效的授权
    16004	 unauthorization_client	 未授权的client
    16005	 unsupported_grant_type	 未知的授权类型
    16006	 invalid_scope	 无效的范围
    16007	 invalid_token	 无效的token(不存在或者已过期)
    16008	 redirect_uri_mismatch	 传入的跳转uri和注册的不匹配
    16009	 unsupported_response_type	 不支持的响应类型
    16010	 access_denied	 访问被拒绝
    16013	 channel id is invalid	 channel id is invalid
    20001	 parent is invalid	 parent is invalid
    20002	 hidden is invalid	 hidden is invalid
    20003	 path is invalid	 path is invalid
    20004	 last_id is invalid	 last_id is invalid
    20005	 page_size is invalid	 page_size is invalid
    20006	 blocks is invalid	 blocks is invalid
    20008	 overwrite is invalid	 overwrite is invalid
    20009	 encrypt is invalid	 encrypt is invalid
    20016	 uuid is invalid	 uuid is invalid
    20018	 when rename the name is invalid	 when rename the name is invalid
    20020	 uploaded file is invalid	 uploaded file is invalid
    20021	 checksum is wrong	 checksum is wrong
    20022	 upload fail to S3	 upload fail to S3
    20027	 same filename has in destfile	 same filename has in destfile
    20030	 fileId is invalid	 fileId is invalid
    20031	 destid is invalid	 destid is invalid
    20033	 version file not found	 version file not found
    20034	 version is invalid	 version is invalid
    20035	 file has existed	 file has existed
    20036	 check_md5 is invalid	 check_md5 is invalid
    20037	 deviceId is blank	 deviceId is blank
    20038	 index is invalid	 index is invalid
    20039	 deviceId is invalid	 deviceId is invalid
    20040	 eventId is invalid	 eventId is invalid
    20041	 clip duration is used up	 clip duration is used up
    20042	 There are not sections in this period!	 There are not sections in this period!
    30001	 file not found	 file not found
    30002	 path and fileId are both null	 参数中path和fileId都为空
    30004	 out of storage space	 用户可用空间不足
    30005	 dest is invalid	 copy的dest非目录
    30006	 This device has been linked in current account.	 该设备device在当下用户下已经关联
    30007	 This device has been linked in another account.	 该设备device在其他用户下已经关联
    30008	 cover is invalid	 cover is invalid
    30009	 did is invalid	 did is invalid
    30010	 recursion is invalid	 recursion is invalid
    30011	 deviceName is invalid	 deviceName is invalid
    30012	 parent and path all null	 parent and path all null
    30013	 upgrade parameter is invalid	 upgrade parameter is invalid
    30014	 order is invalid	 order is invalid
    30015	 thumbnail cut size is invalid
    30016	 assemble file fail
    30017	 invalid vedio duration
    30018	 invalid startTime
    30019	 invalid startOffset
    30020	 invalid size
    30021	 invalid startTimeOffset
    30022	 invalid offsetId
    30023	 invalid start date
    30024	 invalid end date
    30025	 invalid time zone
    30026	 fileId and offsetId not match
    30027	 The expiredStatus of current device has been already updated to 1 .
    30028	 invalid blockStorage
    30029	 invalid endTime
    30030	 event id is invalid
    30031	 event id number format exception
    30032	 event name is blank
    30033	 event name has exceeded its max length
    30034	 event tag is blank
    30035	 event tag has exceeded its max length
    30036	 raw_id is invalid
    30037	 this device has no section
    30038	 this device has no event
    30039	 startTime shoud be less than endTime
    30049	 thumbnail size is invalid
    30050	 timestamp is invalid
    30051	 channel name is invalid
    30052	 event type is invalid
    30053	 event name and event tag is not blank at the same time .
    30054	 eventId and thumbnailId both blank
    30055	 AMQP address is wrong
    30056	RabbitMQ publish wrong
    40001	 tcp server not connect	 TCP 服务器连接错误。请检查相关连接是否正确，或者 TCP 数据源是否已经开启
    40002	 udp server port error	 UDP 服务器获取端口号失败，请检查服务器，或者分配可用端口号失败
    40003	 udp local port error	 UDP 服务器获取本机地址失败，请检查服务器
    40004	 kill ffmpeg error	 杀死 ffmpeg 进程失败，请检查参数是否正确
    40005	 url not found	 查找 url 失败，请检查 deviceId 参数是否正确
    40006	 ffmpeg process not found	 查找 ffmpeg 进程失败，该进程可能已被杀死
    40007	 token blank	 token为空
    40010	 channel_name is blank	 channel_name is blank
    40011	 udp not found	 找不到UDP 接收端主机，请检查相关连接是否正确，或者 UDP 接收端主机是否已经开启
    40012	 udp closed	 UDP 接收端主机已经关闭
    40013	 udp send fail	 UDP 发送数据失败，请检查 UDP 连接
    40014	 get pid fail	 获取 ffmpeg 进程 ID 失败，该进程可能已经关闭
    40015	 get pid failed	 获取 ffmpeg 进程 ID 失败，请检查系统环境
    40016	 cds_url blank	 cds_url 为空
    40018	 cds not connect	 cds 连接失败，请检查参数或者连接是否正常
    40019	 ffmpeg fail	 ffmpeg 转码裸文件失败，请检查服务器，或者 cds 连接
    40020	 download fail	 文件下载失败，请检查服务器，或者 cds 连接
    40021	 there is no ipcam online	 there is no ipcam online
    40022	 ipcam exception	 ipcam 未知异常，请检查ipcam
    40023	 raw file fail	 裸文件解析失败
    40024	 unknow format	 unknow format，请查看裸文件是否解析成功
    40025	 relay:cloud authentication error	 relay server error code 2001:cloud authentication error
    40026	 relay:cloud have no space	 relay server error code 2007:cloud have no space
    40027	 relay:cloud device status error	 relay server error code 2008:cloud device status error
    40028	 relay:no ipcam on line	 relay server error code 2009:no ipcam on line
    40029	 relay:get cloud device status error	 relay server error code 2010:get cloud device status error
    40030	 relay:download connection exceed max num	 relay server error code 2011:download connection exceed max num
    40031	 relay:download connection exits	 relay server error code 2013:download connection exits
    40032	 ssl sock connect time out	 SSL socket 连接超时
    40033	 get relay host ip failed, invalid client request	 get relay host ip failed, invalid client request
    40034	 get relay host ip failed, connect to full relay time out	 get relay host ip failed, connect to full relay time out
    40400	 Sorry, the file you want to visit does not exist!	 Sorry, the file you want to visit does not exist!
    40401	 makeClip time out;	 makeClip time out;
    40402	 makeClip failed	 makeClip failed
    40403	 fileId and urlCode invalid	 fileId and urlCode invalid
    40404	 deviceId and did invalid
 
 */
    CloseliError_Cloud,
};

#endif
