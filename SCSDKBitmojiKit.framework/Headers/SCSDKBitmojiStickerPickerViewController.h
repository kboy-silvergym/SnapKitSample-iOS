//
//  SCSDKBitmojiStickerPickerViewController.h
//  SCSDKBitmojiKit
//
//  Created by Yang Gao on 5/26/18.
//  Copyright © 2018 Snap, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCSDKBitmojiStickerPickerViewController;

@protocol SCSDKBitmojiStickerPickerViewControllerDelegate <NSObject>
@required
- (void)bitmojiStickerPickerViewController:(nonnull SCSDKBitmojiStickerPickerViewController *)stickerPickerViewController
                   didSelectBitmojiWithURL:(nonnull NSString *)bitmojiURL;
@optional
- (void)bitmojiStickerPickerViewController:(nonnull SCSDKBitmojiStickerPickerViewController *)stickerPickerViewController
        searchFieldFocusDidChangeWithFocus:(BOOL)hasFocus;
@end

@interface SCSDKBitmojiStickerPickerViewController : UIViewController

@property (nonatomic, weak, nullable) id<SCSDKBitmojiStickerPickerViewControllerDelegate> delegate;

- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                                 bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;

@end
