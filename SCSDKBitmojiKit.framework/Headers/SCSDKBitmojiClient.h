//
//  SCSDKBitmojiClient.h
//  SCSDKBitmojiKit
//
//  Created by Luke Zhao on 2017-11-03.
//  Copyright © 2017 Bitmoji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BitmojiGetAvatarURLCompletionBlock)(NSString * _Nullable avatarURL, NSError * _Nullable error);

/**
 * This is the interface for fetching Bitmoji content from resource servers
 */
@interface SCSDKBitmojiClient : NSObject

+ (void)fetchAvatarURLWithCompletion:(nonnull BitmojiGetAvatarURLCompletionBlock)completion;

@end
