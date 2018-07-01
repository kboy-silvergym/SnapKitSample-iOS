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

class CameraViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
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
    
    @IBAction func snapButtonTapped(_ sender: Any) {
        let snapshot = sceneView.snapshot()
        let photo = SCSDKSnapPhoto(image: snapshot)
        let snap = SCSDKPhotoSnapContent(snapPhoto: photo)
        snap.attachmentUrl = "https://www.graffity.jp/"
        
        let api = SCSDKSnapAPI(content: snap)
        api.startSnapping { error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                // success
            }
        }
    }
}
