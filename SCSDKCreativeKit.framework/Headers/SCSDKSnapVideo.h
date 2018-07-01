//
//  SCSDKSnapVideo.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCSDKSnapVideo : NSObject<NSSecureCoding>

/**
 * @property videoUrl
 * @brief File URL to the file to be used as video for a Snap.
 */
@property (nonatomic, copy, readonly) NSURL * _Nonnull videoUrl;

/**
 * Initializes an SCSDKSnapVideo instance.
 *
 * @param videoUrl NSURL of a video file on disk to be used as a Snap.
 * @return An SCSDKSnapVideo instance initialized with videoUrl.
 */
- (instancetype _Nonnull)initWithVideoUrl:(NSURL * _Nonnull)videoUrl;

@end
