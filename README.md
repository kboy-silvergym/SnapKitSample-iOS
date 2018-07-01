![snapkit-sample-ios](https://user-images.githubusercontent.com/17683316/42133453-51ae48ea-7d65-11e8-980c-3a93026255d2.png)

This is an unofficial demo app of the Snap Kit produced by SnapChat.

## Login Kit demo
<img src="https://user-images.githubusercontent.com/17683316/42131965-12afd184-7d49-11e8-931b-0ef5578157df.png" width="100">

First of all, you should check this document.
https://docs.snapchat.com/docs/login-kit/

Following this document, you can implement SnapChat login. 
You can fetch displayName & avatar (bitmoji avatar) so far.

<img src="https://user-images.githubusercontent.com/17683316/42132023-729a370a-7d4a-11e8-9fff-c93cd4940e69.gif" width="250">


There're some difficult points, so I note about that here.

### Equalize Info.plist's `SCSDKRedirectUrl` with `Redirect URLs` on SnapChat Developer Portal (https://kit.snapchat.com/portal/)

If you didn't equalize that, the SnapChat App would show the error.

### Don't use `-` in your app's url scheme.

If you use `-` like `snap-client`, the SnapChat App would show the error.
I don't know the reason, but it seems to be the rule of SnapChat Developer Potal.

## Creative Kit
<img src="https://user-images.githubusercontent.com/17683316/42131997-9b7b3b8e-7d49-11e8-9651-092cf14fed1e.png" width="100">

Following this document https://docs.snapchat.com/docs/creative-kit/ 
This is so easy to code.

Only you should do is just coding like below.

```swift
import SCSDKCreativeKit

let snapshot = sceneView.snapshot() // Any image is OK. In this codes, SceneView's snapshot is passed.
let photo = SCSDKSnapPhoto(image: snapshot)
let snap = SCSDKPhotoSnapContent(snapPhoto: photo)
snap.attachmentUrl = "https://newcapsulecorp.com"
        
let api = SCSDKSnapAPI(content: snap)
api.startSnapping { error in
            
    if let error = error {
        print(error.localizedDescription)
    } else {
    // success
    
    }
}
```

<img src="https://user-images.githubusercontent.com/17683316/42136191-ef25554c-7d91-11e8-97ac-42df7903dbbb.gif" width="250">

## Bitmoji Kit
<img src="https://user-images.githubusercontent.com/17683316/42131995-9914d864-7d49-11e8-95de-f8c053b2f706.png" width="100">

WIP..

## Reference
https://kit.snapchat.com/
https://storage.googleapis.com/snap-inc/brand-guidelines/snapchat-brand-standards.pdf
