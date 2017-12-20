//
//  CloseliCameraUpdateInfo.h
//  Security
//
//  Created by Zhou'sMac 10.8 on 9/6/13.
//
//
typedef NS_ENUM(NSInteger, CloseliUpdateType_E) {
    CloseliUpdateType_none = 0,
    CloseliUpdateType_need,
    CloseliUpdateType_force
};

typedef NS_ENUM(NSUInteger, CloseliUpdateUrlType_E) {
    CloseliUpdateUrlType_fireware = 1,
    CloseliUpdateUrlType_app
};

/**
 *  A CloseliCameraUpdateInfo object represents a camera update info.
 *
 * CloseliCameraUpdateInfo object manages a collection of property and provides some functions that can be used to get camera current version, camera firmware version, the latest camera version, the latest firmware version, camera update type and update URL,etc.
 * So ,You can decide by getting the CloseliCameraUpdateInfo object to update the camera version.
 */
@interface CloseliCameraUpdateInfo : NSObject

///data which used for detecting error. not used.
@property (nonatomic, copy) NSString *checksum;

///camera current application version.
@property (nonatomic, copy) NSString *currentAppVersion;

///camera current firmware version.
@property (nonatomic, copy) NSString *currentFirmwareVersion;

///the latest camera application version.
@property (nonatomic, copy) NSString *latestAppVersion;

///the latest camera firmware version.
@property (nonatomic, copy) NSString *latestFirmwareVersion;

///whether camera need to update.
@property (nonatomic, assign) CloseliUpdateType_E updateType;

///the update url.
@property (nonatomic, copy) NSString *updateURL;

///app update url or firmware update url.
@property (nonatomic, assign) CloseliUpdateUrlType_E urlType;

@end
