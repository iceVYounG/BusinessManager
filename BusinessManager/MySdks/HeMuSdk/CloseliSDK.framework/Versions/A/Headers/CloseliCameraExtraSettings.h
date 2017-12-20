//
//  CloseliCameraExtraSettings.h
//
//  Created by Xia H on 13-6-25.
//
//


#import "CloseliScheduleInfo.h"

/**
 *  A CloseliCameraExtraSettings object that contains camera extra info,which marked a number of parameters of the camera.
 */
@interface CloseliCameraExtraSettings : NSObject

///Camera name
@property (nonatomic, strong) NSString *name;
///Camera Turn on/off
@property (nonatomic, assign) BOOL bTurnOn;

///If support motion detection notification, it just mean not to send notification, but detect still take effect.
@property (nonatomic, assign) BOOL bMotionDetect;
///Sensitive for motion detection, should between 0 to 100
@property (nonatomic, assign) int nMotionSensitive;

///If support sound detection notification, it just mean not to send notification, but detect still take effect.
@property (nonatomic, assign) BOOL bSoundDetect;
///Sensitive for sound detection, should between 0 to 100
@property (nonatomic, assign) int nSoundSensitive;

///If support micro phone of camera
@property (nonatomic, assign) BOOL cameraMicrophone;
///If support email alerts
@property (nonatomic, assign) BOOL emailAlerts;
///camera night mode, 0-off, 1-on, 2-auto
@property (nonatomic, assign) int nightMode;
///If led of camera on or off
@property (nonatomic, assign) BOOL ledLight;

///Switch between HD(720P)/SD(VGA), 0-off(SD), 1-on(HD), 2-auto
@property (nonatomic, assign) int HDVideo;
///Video quality, value:VIDEO_QUALITY_LOW(qvga)=1, VIDEO_QUALITY_MEDIUM(vga)=2, VIDEO_QUALITY_HIGH(720p)=3(default) or VIDEO_QUALITY_VHIGH(1080p)=4.
///NOTICE: UNAVAILABLE FOR MYFOX
@property (nonatomic, assign) long videoQuality;

/// Specifies a type that setting camera's timezone. Param should be
///     [NSTimeZone description];
/// Since you get full descritiopn @"Europe/Paris (GMT+1) offset 3600"
///     please pass @"Europe/Paris" or Abbreviation presentation(@"CEST") as the time zone value.
/// Get all available abbreviations, call [NSTimeZone abbreviationDictionary].
@property (nonatomic, strong) NSString *cameraTimeZone;
///Anti Flicker Frequency, 50 or 60HZ
@property (nonatomic, assign) int nFrequency;
///0 or 180 degree
@property (nonatomic, assign) int rotateDegree;

///If support cloud record
@property (nonatomic, assign) BOOL cloudRecord;
///Schedule to record on cloud, CloseliScheduleInfo * in it
@property (nonatomic, strong) NSArray *scheduleCloudRecord;

///Schedule to turn camera off, CloseliScheduleInfo * in it
@property (nonatomic, strong) NSArray *scheduleTurnOff;
///Schedule to turn motion dectection notification off, CloseliScheduleInfo * in it
@property (nonatomic, strong) NSArray *scheduleStopNotification;
///Schedule to mute camera, CloseliScheduleInfo * in it
@property (nonatomic, strong) NSArray *scheduleMute;

///Array to set motion region, CloseliMotionRegion * in it
///     if enable in CloseliMotionRegion is 0, valid motion region capacity is 3, else 4.
@property (nonatomic, strong) NSArray *motionRegions;

///zoom ratio for the camera to set. 1000<=value<=4000(default:1000), you must set magicZoomXOffset and magicZoomYOffset simultaneously
@property (nonatomic, assign) int magicZoomRatio;
///X offset of zoom of the camera(origin top left). value:0-1000(default:0), you must set magicZoomRatio and magicZoomYOffset simultaneously
@property (nonatomic, assign) int magicZoomXOffset;
///Y offset of zoom of the camera(origin top left). value:0-1000(default:0), you must set magicZoomRatio and magicZoomXOffset simultaneously
@property (nonatomic, assign) int magicZoomYOffset;

///Is mechanical shutter of the camera on, YES-Cover is opened, NO-Cover is closed.
@property (nonatomic, assign) BOOL mechanicalShutter;
///If send pir notification,
@property (nonatomic, assign) BOOL pirDetection;
///Is the power of camera is off, and the camere in battery mode.
@property (nonatomic, assign) BOOL batteryMode;
///If send tamper detection notification,
@property (nonatomic, assign) BOOL tamperDetection;
///wifi quality of the camera. value:0-100, The signal value is fetched from "nmcli dev wifi list"
@property (nonatomic, assign) int wifiQuality;
///Wifi SSID of the camera
@property (nonatomic, strong) NSString *cameraSSID;
///SelfDefine value.
@property (nonatomic, strong) NSData *userDefinedData;

@property (nonatomic, strong) NSString *deviceType;//Camera model type

+ (void)setSupport:(NSString *)supportString forProperty:(NSString *)propertyString;
- (BOOL)checkSupportForValue:(id)value supportString:(NSString *)supportString;

@end
