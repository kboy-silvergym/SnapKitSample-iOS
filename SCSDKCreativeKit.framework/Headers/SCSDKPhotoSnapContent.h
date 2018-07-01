//
//  SCSDKPhotoSnapContent.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import "SCSDKSnapContent.h"
#import "SCSDKSnapPhoto.h"

#import <Foundation/Foundation.h>

@interface SCSDKPhotoSnapContent : NSObject<SCSDKSnapContent>

/**
 * @property snapPhoto
 * @brief SCSDKSnapPhoto instance containing image data required for creating a still Snap.
 */
@property (nonatomic, strong, readonly) SCSDKSnapPhoto * _Nonnull snapPhoto;

/**
 * Initializes an SCSDKPhotoSnapContent instance.
 *
 * @param snapPhoto SCSDKSnapPhoto instance containing image data to be used as a Snap.
 * @return An SCSDKPhotoSnapContent instance initialized with snapPhoto.
 */
- (instancetype _Nonnull)initWithSnapPhoto:(SCSDKSnapPhoto * _Nonnull)snapPhoto;

@end
