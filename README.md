![snapkit-sample-ios](https://user-images.githubusercontent.com/17683316/42133453-51ae48ea-7d65-11e8-980c-3a93026255d2.png)

This is an **unofficial** demo app of the Snap Kit produced by SnapChat.

## Installation

You can install `SnapSDK` via Cocoapods.

```ruby
pod 'SnapSDK', :subspecs => ['SCSDKLoginKit', 'SCSDKCreativeKit', 'SCSDKBitmojiKit']
```

## Login Kit
<img src="https://user-images.githubusercontent.com/17683316/42131965-12afd184-7d49-11e8-931b-0ef5578157df.png" width="100">

First of all, you should check this document.
https://docs.snapchat.com/docs/login-kit/

Following this document, you can implement SnapChat login. 

You can fetch displayName & avatar (bitmoji avatar) so far.

<img src="https://user-images.githubusercontent.com/17683316/42132023-729a370a-7d4a-11e8-9fff-c93cd4940e69.gif" width="250">

### 1.Call Login Method when the button tapped

```swift
@IBAction func loginButtonTapped(_ sender: Any) {
    SCSDKLoginClient.login(from: self, completion: { success, error in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if success {
            self.fetchSnapUserInfo()
        }
    })
}
```

### 2.After login, fetch user datas

One of the interesting things is that Snap Kit is using the GraphQL not the RestAPI.

If you don't know the GraphQL, you should check this https://graphql.org/

And this codes, I made UserEntity which is inheriting Decodable because using it is easier to parse JSON I think. But of cource this is not the only way to parse JSON, choose the way what you like.

```swift
private func fetchSnapUserInfo(){
    let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
    
    SCSDKLoginClient
        .fetchUserData(
            withQuery: graphQLQuery,
            variables: nil,
            success: { userInfo in
                
                if let userInfo = userInfo,
                    let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted),
                    let userEntity = try? JSONDecoder().decode(UserEntity.self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.goToLoginConfirm(userEntity)
                    }
                }
        }) { (error, isUserLoggedOut) in
            print(error?.localizedDescription ?? "")
    }
}
```

### 3.Some Adveices

There're some difficult points, so I note about that here.

#### Equalize Info.plist's `SCSDKRedirectUrl` with `Redirect URLs` on SnapChat Developer Portal (https://kit.snapchat.com/portal/)

If you didn't equalize that, the SnapChat App would show the error.

#### Don't use `-` in your app's url scheme.

If you use `-` like `snap-client`, the SnapChat App would show the error.
I don't know the reason, but it seems to be the rule of SnapChat Developer Potal.

## Creative Kit
<img src="https://user-images.githubusercontent.com/17683316/42131997-9b7b3b8e-7d49-11e8-9651-092cf14fed1e.png" width="100">

Following this document https://docs.snapchat.com/docs/creative-kit/ 

This is so easy to code.

You can share a photo or video attaching a sticker, url, and caption.

<img src="https://user-images.githubusercontent.com/17683316/42210546-402b855a-7eec-11e8-91f1-4c04e3242113.gif" width="250">

### Sample Code

```swift
import SCSDKCreativeKit

let snapshot = sceneView.snapshot() // Any image is OK. In this codes, SceneView's snapshot is passed.
let photo = SCSDKSnapPhoto(image: snapshot)
let snap = SCSDKPhotoSnapContent(snapPhoto: photo)

// Sticker
let sticker = SCSDKSnapSticker(stickerImage: #imageLiteral(resourceName: "snap-ghost"))
snap.sticker = sticker
        
// Caption
snap.caption = "Snap on Snapchat!"
        
// URL
snap.attachmentUrl = "https://www.snapchat.com"
        
let api = SCSDKSnapAPI(content: snap)
api.startSnapping { error in
            
    if let error = error {
        print(error.localizedDescription)
    } else {
        // success
    
    }
}
```

If you use `SCSDKVideoSnapContent`, you can share the videos.

## Bitmoji Kit
<img src="https://user-images.githubusercontent.com/17683316/42131995-9914d864-7d49-11e8-95de-f8c053b2f706.png" width="100">

### Fetch avatar image

You can fetch your avatar image by coding like below codes.

```swift
import SCSDKBitmojiKit

// fetch your avatar image.
SCSDKBitmojiClient.fetchAvatarURL { (avatarURL: String?, error: Error?) in
    DispatchQueue.main.async {
        if let avatarURL = avatarURL {
            self.iconView.load(from: avatarURL)
        }
    }
}
```

### Show bitmoji pickerview

The SCSDKBitmojiStickerPickerViewController is prepared in SCSDKBitmojiKit.

You can add the picker view as child viewController. It's very easy.

```swift
@IBAction func bitmojiButtonTapped(_ sender: Any) {
    // Make bitmoji background view
    let viewHeight: CGFloat = 300
    let screen: CGRect = UIScreen.main.bounds
    let backgroundView = UIView(
        frame: CGRect(
            x: 0,
            y: screen.height - viewHeight,
            width: screen.width,
            height: viewHeight
        )
    )
    view.addSubview(backgroundView)
    bitmojiSelectionView = backgroundView
    
    // add child ViewController
    let stickerPickerVC = SCSDKBitmojiStickerPickerViewController()
    stickerPickerVC.delegate = self
    addChildViewController(stickerPickerVC)
    backgroundView.addSubview(stickerPickerVC.view)
    stickerPickerVC.didMove(toParentViewController: self)
}
```

### Inherit SCSDKBitmojiStickerPickerViewControllerDelegate

If you Inherit SCSDKBitmojiStickerPickerViewControllerDelegate, you can track events when the piker is selected, and the serach field is focused.

In this demo codes, it makes the AR stamps by the URL of bitmoji and place to the sceneView.

```swift
extension CameraViewController: SCSDKBitmojiStickerPickerViewControllerDelegate {
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, didSelectBitmojiWithURL bitmojiURL: String) {
        
        bitmojiSelectionView?.removeFromSuperview()
        
        if let image = UIImage.load(from: bitmojiURL) {
            DispatchQueue.main.async {
                self.setImageToScene(image: image)
            }
        }
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, searchFieldFocusDidChangeWithFocus hasFocus: Bool) {
        
    }
}
```

<img src="https://user-images.githubusercontent.com/17683316/42438970-8c02222c-839c-11e8-8ccb-5b0d266aa02a.gif" width="250">

## Reference
- https://kit.snapchat.com/
- https://storage.googleapis.com/snap-inc/brand-guidelines/snapchat-brand-standards.pdf
