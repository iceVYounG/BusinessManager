//
//  CloudUploadParam.h
//
//  Created by Zhou Hao on 1/15/13.
//
//

/// file type code
typedef NS_ENUM(NSInteger, ASFileType) {
    AS_FILETYPE_OTHER = 0,              ///< Other files
	AS_FILETYPE_FOLDER = 4,             ///< Folder/Directory
    AS_FILETYPE_LECAM_SAVED_CLIP = 100,
};

@interface CloseliCloudFileInfo : NSObject

@property (nonatomic, copy) NSString *deviceUUID;

@property (nonatomic, copy) NSString *szName;///< file's name
@property (nonatomic, copy) NSString *szPathRemote;///< path in server
@property (nonatomic, copy) NSString *szDownloadServer;///< host name for Closeli server
@property (nonatomic, copy) NSString *szComments;//
@property (nonatomic, copy) NSString *szDuration;//video duration
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, assign) BOOL isHidden;///< file is hidden or not
@property (nonatomic, assign) int64_t llSize;///< file's size
@property (nonatomic, assign) int eUploadStatus;//upload state,
@property (nonatomic, assign) ASFileType fileType;//file type in ASFileType
@property (nonatomic, assign) int version;///file version in Closeli server

///readonly items
@property(nonatomic, copy) NSString *szFileID;///< the unique file id in Closeli server
@property(nonatomic, copy) NSString *szParentID;///< the parent id in Closeli server
@property(nonatomic, copy) NSString *szThumbnailID;//thumbnail id in Closeli server

@property(nonatomic, strong) CloseliCloudFileInfo *parentFile;

- (id)initWithOther:(CloseliCloudFileInfo *)otherFile;

- (NSString *)getThumbnailURL;
- (NSString *)getSourceURL;

@end
