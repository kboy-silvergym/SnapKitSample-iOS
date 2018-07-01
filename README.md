# SnapKitSample

## Login Kit demo

First of all, you should check this document.
https://docs.snapchat.com/docs/login-kit/

Following this document, you can implement SnapChat login. But there're some difficult points, so I note about that here.

### Equalize Info.plist's `SCSDKRedirectUrl` with `Redirect URLs` on SnapChat Developer Portal (https://kit.snapchat.com/portal/)

If you didn't equalize that, the SnapChat App would show the error.

### Don't use `-` in your app's url scheme.

If you use `-` like `snap-client`, the SnapChat App would show the error.
I don't know the reason, but it seems to be the rule of SnapChat Developer Potal.

## Creative Kit

WIP..

## Bitmoji Kit

WIP..



