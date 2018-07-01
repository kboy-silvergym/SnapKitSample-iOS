//
//  SCSDKLoginButton.h
//  SCSDKLoginKit
//
//  Copyright © 2018 Snap, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCSDKLoginButtonDelegate
- (void)loginButtonDidTap;
@end

@interface SCSDKLoginButton : UIView

@property (nonatomic, weak, nullable) id<SCSDKLoginButtonDelegate> delegate;

@end
