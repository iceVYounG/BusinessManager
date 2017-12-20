//
//  CloseliTimelineEventClip.h
//  LeCam
//
//  Created by Xia H on 13-10-22.
//
//

#import <Foundation/Foundation.h>
/**
 *  Specifies a CloseliTimelineEventClip type that indicates the event type.
 */
typedef NS_ENUM(NSUInteger, EventType_E)
{
    /**
     *  Specifies a event type caught by motion detection.
     */
    KEventTypeMotion = 1,
    /**
     *  Specifies a event type caught by sound detection.
     */
    KEventTypeSound = 2,
    /**
     *  Specifies a event type caught by face detection.
     */
    KEventTypeFace = 3,
    /**
     *  Specifies a event type caught when camera is tampered with something.
     */
    KEventTypeTamper = 11,
    /**
    *  Specifies a event type caught when camera is change to battery mode.
    */
    KEventTypeBatteryMode = 12,
    /**
    *  Specifies a event type caught by PIR detection.
    */
    KEventTypePIR = 13,
    /**
     *  Specifies a event type caught when mechanical shutter of camera is opened.
     */
    KEventTypeShutterOpen = 100,
    /**
     *  Specifies a event type caught when mechanical shutter of camera is closed.
     */
    KEventTypeShutterClose = 101,
    /**
     *  Specifies a event type caught when power mode changed between power and battery.
     */
    KEventTypePowerMode = 102,
    /**
     *  Specifies a event type caught when battery quantity changed.
     */
    KEventTypeBatteryQuantity = 103,
    /**
     *  Specifies a event type caught by delete
     */
    KEventTypeDelete = 120,
    /**
     *  Specifies a event type caught by PIR and motion detection.
     */
    KEventTypePIRMotion = 131,
};

/**
 *  A CloseliTimelineEventClip object means a event clip. It manages a collection of property and some functions that can be used to get url of the event thumbnail,or get current timeline event's type.
 */
@interface CloseliTimelineEventClip : NSObject<NSCopying>
{
    
}
///Gets and sets a string that indicates a timeline event.
@property (nonatomic, strong) NSString *eventID;
///Specifies a events type, by motion, by sound, or by face detection.
@property (nonatomic, assign) EventType_E eventType;
///a tag string that specifies a event tag.
@property (nonatomic, strong) NSString *eventTag;
///A string that specifies a event name.
@property (nonatomic, strong) NSString *eventName;
///A url string that specifies the download address.
@property (nonatomic, strong) NSString *downloadURL;
///A date that indicates the start time. UTC time.
@property (nonatomic, strong) NSDate *startTime;
///A date that indicates the end time. UTC time.
@property (nonatomic, strong) NSDate *endTime;

/**
 *  Gets the url of the event's thumbnail.
 *
 *  @return a string that indicates the url.
 */
- (NSString *)getThumbnailURL;

@end
