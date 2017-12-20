//
//  CloseliSDK+SDCard.h
//  CloseliSDK
//
//  Created by xtturing on 15/9/10.
//  Copyright (c) 2015年 arcsoft. All rights reserved.
//

#import <CloseliSDK/CloseliSDK.h>

@interface CloseliSDK (SDCard)

/**
 *  Description
 *
 *  @param cameraDevice   cameraDevice description
 *  @param startTime      startTime description
 *  @param endTime        endTime description
 *  @param timelineType   timelineType description
 *  @param pptimelineData pptimelineData description
 *  @param error          error description
 *
 *  @return return value description
 */
- (BOOL)getTimelineFromSDCard:(CloseliCameraDevice *)cameraDevice
                withStartTime:(NSDate *)startTime
                  withEndTime:(NSDate *)endTime
                    withPageSize:(NSInteger)pageSize
                     withType:(eCloseliTimelineType)timelineType
                       toData:(CloseliTimelineData *__autoreleasing *)pptimelineData
                        error:(NSError *__autoreleasing *)error;

/**
 *  Description
 *
 *  @param cameraDevice cameraDevice description
 *  @param eventClip    eventClip description
 */
- (UIImage *)getThumbnailFromSDCardEvent:(CloseliCameraDevice *)cameraDevice
                          withEvent:(CloseliTimelineEventClip *)eventClip;

/**
 *  Description
 */
- (void)cancelSDCardTimelineGetting;

/**
 *  Description
 *
 *  @return return value description
 */
- (BOOL)isSDCardTimelineCancelled;

@end
