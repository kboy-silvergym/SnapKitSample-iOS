//
//  ViewController.swift
//  SnapClient
//
//  Created by Kei Fujikawa on 2018/06/15.
//  Copyright © 2018年 Kboy. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SCSDKCreativeKit
import SCSDKBitmojiKit

class CameraViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var iconView: UIImageView! {
        didSet {
            iconView.backgroundColor = .white
            iconView.layer.cornerRadius = iconView.frame.width/2
            iconView.clipsToBounds = true
        }
    }
    
    private var bitmojiSelectionView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
        
        // fetch your avatar image.
        SCSDKBitmojiClient.fetchAvatarURL { (avatarURL: String?, error: Error?) in
            DispatchQueue.main.async {
                if let avatarURL = avatarURL {
                    self.iconView.load(from: avatarURL)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    
    // MARK: About creating node
    
    private func setImageToScene(image: UIImage) {
        if let camera = sceneView.pointOfView {
            let position = SCNVector3(x: 0, y: 0, z: -0.5)
            let convertedPosition = camera.convertPosition(position, to: nil)
            let node = createPhotoNode(image, position: convertedPosition)
            self.sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    private func createPhotoNode(_ image: UIImage, position: SCNVector3) -> SCNNode {
        let node = SCNNode()
        let scale: CGFloat = 0.3
        let geometry = SCNPlane(width: image.size.width * scale / image.size.height,
                                height: scale)
        geometry.firstMaterial?.diffuse.contents = image
        node.geometry = geometry
        node.position = position
        return node
    }
    
    @IBAction func snapButtonTapped(_ sender: Any) {
        let snapshot = sceneView.snapshot()
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
    }
    
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
}

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
