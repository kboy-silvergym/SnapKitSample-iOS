//
//  SCSDKSnapErrorCode.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

@import Foundation;

#define SC_SDK_SNAP_ERROR_DOMAIN @"SCSDKSnapErrorDomain"

typedef NS_ENUM(NSInteger, SCSDKSnapErrorCode) {
    SCSDKSnapMainContentFailure = 0,
    SCSDKSnapStorageLinksUnexpectedStatusCode = 1,
    SCSDKSnapStorageLinksUnexpectedResponse = 2,
    SCSDKSnapUploadUnexpectedStatusCode = 3,
    SCSDKSnapMalformattedSnapContent = 4,
    SCSDKSnapStickerContentFailure = 5,
    SCSDKSnapDeepLinkFailure = 6,
    SCSDKSnapStorageLinksCacheFetchFailure = 7,
    SCSDKSnapEncryptionMetadataCacheFetchFailure = 8,

    SCSDKSnapEncryptionMetadataUnexpectedStatusCode = 9,
    SCSDKSnapEncryptionMetadataUnexpectedResponse = 10,

    SCSDKUnknownErrorCode = -1,
};
