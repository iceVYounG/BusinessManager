//
//  CloseliScheduleInfo.h
//  Security
//
//  Created by ArcSoft.
//  Copyright (c) 2014 ArcSoft. All rights reserved.
//
/**
 *  Specifies a schedule repeat type.
 */
typedef NS_ENUM(NSUInteger, eScheduleRepeatType)
{
    /**
     *  Only once
     */
    DEVICE_SCHEDULE_REPEAT_ONCE = 0,
    /**
     *  Repeat everyday
     */
    DEVICE_SCHEDULE_REPEAT_EVERYDAY,
    /**
     *  Repeat weekly
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY,
    /**
     *  Repeat monthly
     */
    DEVICE_SCHEDULE_REPEAT_MONTHLY,
};

/**
 *  a enum type that indicates the schedule repeat mode.
 */
typedef NS_ENUM(NSUInteger, eScheduleRepeatDayType)
{
    /**
     *  Repeat every sunday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_SUNDAY	= 0x0001,
    /**
     *  Repeat every monday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_MONDAY	= 0x0002,
    /**
     *  Repeat every tuesday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_TUESDAY	= 0x0004,
    /**
     *  Repeat every wednesday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_WEDNESDAY	= 0x0008,
    /**
     *  Repeat every thursday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_THURSDAY	= 0x0010,
    /**
     *  Repeat every friday.
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_FRIDAY        = 0x0020,
    /**
     *  Repeat every saturday
     */
    DEVICE_SCHEDULE_REPEAT_WEEKLY_SATURDAY	= 0x0040,
};

/**
 *  A scheduleInfo object is a schedule that used for camera to execute.
 */

@interface CloseliScheduleInfo : NSObject <NSCopying>

///GUID for this schedule
@property (nonatomic, strong) NSString *scheduleGUID;
///Camera deviceUUID (in CloseliCameraDevice *)
@property (nonatomic, strong) NSString *deviceUUID;
///Schedule begin time,UTC time.
@property (nonatomic, strong) NSDate *beginTime;
///Schedule end time,UTC time.
@property (nonatomic, strong) NSDate *endTime;
///Schedule repeat type
@property (nonatomic, assign) eScheduleRepeatType nRepeatType;
///Repeat days, combine with eScheduleRepeatDayType, something like DEVICE_SCHEDULE_REPEAT_WEEKLY_SUNDAY | DEVICE_SCHEDULE_REPEAT_WEEKLY_MONDAY
@property (nonatomic, assign) int nRepeatly;
///Schedule status, on or off.
@property (nonatomic, assign) BOOL scheduleON;

@end
