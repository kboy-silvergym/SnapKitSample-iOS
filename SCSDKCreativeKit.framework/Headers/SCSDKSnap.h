//
//  SCSDKSnap.h
//  SCSDKCreativeKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import "SCSDKSnapContent.h"

#import <Foundation/Foundation.h>

@protocol SCSDKSnapDelegate;

@protocol SCSDKSnap <NSObject>

@property (nonatomic, strong) id<SCSDKSnapContent> content;

@property (nonatomic, weak) id<SCSDKSnapDelegate> delegate;

@end

@protocol SCSDKSnapDelegate <NSObject>

- (void)snapper:(id<SCSDKSnap>)snapper didCompleteWithResults:(NSDictionary *)results;

- (void)snapper:(id<SCSDKSnap>)snapper didFailWithError:(NSError *)error;

- (void)snapperDidCancel:(id<SCSDKSnap>)snapper;

@end

