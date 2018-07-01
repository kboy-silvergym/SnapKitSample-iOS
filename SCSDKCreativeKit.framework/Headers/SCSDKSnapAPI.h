//
//  SCSDKSnapAPI.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import "SCSDKSnap.h"
#import "SCSDKSnapContent.h"

#import <Foundation/Foundation.h>

/**
 * Callback to trigger when Snapping is complete.
 *
 * @param error Error that is set when Snapping fails.
 */
typedef void (^SCSDKSnapAPICompletionHandler)(NSError * _Nullable error );

@interface SCSDKSnapAPI : NSObject<SCSDKSnap>

/**
 * Initializes an SCSDKSnapAPI instance.
 *
 * @param content SCSDKSnapContent to be Snapped.
 * @return An SCSDKSnapAPI instance initialized with content and fromViewController.
 */
- (instancetype _Nonnull)initWithContent:(id<SCSDKSnapContent> _Nonnull)content;

/**
 * Starts Snapping.
 *
 * @param completionHandler Block that will run after Snapping is complete. Failure if error is set
 *                          success otherwise.
 */
- (void)startSnappingWithCompletionHandler:(SCSDKSnapAPICompletionHandler _Nullable)completionHandler;

/**
 * Cancels Snapping.
 */
- (void)cancelSnapping;

@end
