//
//  CloseliTimelineData.h
//  LeCam
//
//  Created by Xia H on 13-10-22.
//
//

#import <Foundation/Foundation.h>
#import "CloseliTimelineEventClip.h"
#import "CloseliTimelineSectionClip.h"

/**
 *  Specifies a timeline type that used to get timeline.
 *
 *  If you need to get both,use "|".
 */
typedef NS_ENUM(NSUInteger, eCloseliTimelineType)
{
    /**
     *  Specifies a section timeline where video exists.
     */
    CLOSELITIMELINE_SECTIONS = 0x0001,
    /**
     *  Specifies a event timeline where event happens.
     */
    CLOSELITIMELINE_EVENTS = 0x0002,
};

/**
 *  Class to save timeline data
 */
@interface CloseliTimelineData : NSObject
{
    
}
///A string that identify a camera.
@property (nonatomic, strong) NSString *deviceUUID;
///A date object that specifies start time. UTC time.
@property (nonatomic, strong) NSDate *startTime;
///A date object that specifies end time. UTC time.
@property (nonatomic, strong) NSDate *endTime;
///A string that specifies the url of this file.
@property (nonatomic, strong) NSString *downloadServer;
///A section array which object is a CloseliTimelineSectionClip, used to show sections timeline. Section clips have data.
@property (nonatomic, strong) NSMutableArray *arraySections;
///A enent array which object is a CloseliTimelineEventClip, used to show events timeline. Event clip means have motion at that time.
@property (nonatomic, strong) NSMutableArray *arrayEvents;
/**
 *
 *
 *  @param llTimeInMS the long long int value which specifies the time. It is in milliseconds since 1970.
 *
 *  @return return a string of the timeline thumbnail at the moment of llTimeInMS.
 */
-(NSString *)getThumbnailURLAtTime:(long long)llTimeInMS;

@end
