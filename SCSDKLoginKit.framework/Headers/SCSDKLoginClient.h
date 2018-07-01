//
//  SCSDKLoginClient.h
//  SCSDKLoginKit
//
//  Copyright © 2017 Snap, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Callback to trigger when fetch resource success.
 *
 * @param resources that contain user data.
 */
typedef void(^SCOAuth2GetResourcesSuccessCompletionBlock)(NSDictionary * _Nullable resources);

/**
 * Callback to trigger when fetch resource failed.
 *
 * @param error that happened when fetch data from resource server.
 * @param isUserLoggedOut set to YES if the connection between 3PA and Snapchat is broken or user is not logged in to 3PA using Snapchat. Set to NO if other errors occur while fetching data from Snapchat
 */
typedef void(^SCOAuth2GetResourcesFailureCompletionBlock)(NSError * _Nullable error, BOOL isUserLoggedOut);

static NSString * _Nonnull const kSCSDKLoginClientUserUnlinkNotification = @"kSCSDKLoginClientUserUnlinkNotification";
static NSString * _Nonnull const kSCSDKLoginClientUserLinkNotification = @"kSCSDKLoginClientUserLinkNotification";
static NSString * _Nonnull const kSCSDKLoginClientUserLinkFailedNotification = @"kSCSDKLoginClientUserLinkFailedNotification";

@interface SCSDKLoginClient : NSObject

@property (class, assign, readonly) BOOL isUserLoggedIn;

/**
 * Start Auth with Snapchat.
 *
 * @param viewController that shows the in-app auth page.
 */
+ (void)loginFromViewController:(UIViewController *_Nonnull)viewController
                     completion:(void (^_Nullable)(BOOL success, NSError * _Nullable error))completion;

/**
 * Finish auth with Snapchat.
 *
 * @param application for singleton app object of calling app
 * @param url created by Snapchat.
 * @param options for the url to handle
 * @return YES if Snapchat can open the the url, NO if it cannot
 */
+ (BOOL)application:(UIApplication *_Nonnull)application
            openURL:(NSURL *_Nonnull)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *_Nullable)options;

/**
 * Revoke current session.
 *
 * @param completion block be trigged when finish revoking session.
 */
+ (void)unlinkCurrentSessionWithCompletion:(nullable void (^)(BOOL success))completion;

/**
 * Revoke all sessions.
 *
 * @param completion block be trigged when finish revoking session.
 */
+ (void)unlinkAllSessionsWithCompletion:(nonnull void (^)(BOOL success))completion;

/**
 * Interface to fetch user data from resource server.
 *
 * @param query GraphQL query to fetch user data.
 * @param success Success block when fetch data succeed.
 * @param failure Failure block when fetch data failed.
 */
+ (void)fetchUserDataWithQuery:(nonnull NSString *)query
                     variables:(nullable NSDictionary<NSString *, id> *)variables
                       success:(nonnull SCOAuth2GetResourcesSuccessCompletionBlock)success
                       failure:(nonnull SCOAuth2GetResourcesFailureCompletionBlock)failure;

@end
