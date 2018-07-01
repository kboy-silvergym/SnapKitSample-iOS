//
//  SCSDKVideoSnapContent.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import "SCSDKSnapContent.h"
#import "SCSDKSnapVideo.h"

#import <Foundation/Foundation.h>

@interface SCSDKVideoSnapContent : NSObject<SCSDKSnapContent>

/**
 * @property snapVideo
 * @brief SCSDKSnapVideo instance containing video data required for creating a video Snap.
 */
@property (nonatomic, strong, readonly) SCSDKSnapVideo * _Nonnull snapVideo;

/**
 * Initializes an SCSDKVideoSnapContent instance.
 *
 * @param snapVideo SCSDKSnapVideo instance containing video data to be used as a Snap.
 * @return An SCSDKVideoSnapContent instance initialized with snapVideo.
 */
- (instancetype _Nonnull)initWithSnapVideo:(SCSDKSnapVideo * _Nonnull)snapVideo;

@end
