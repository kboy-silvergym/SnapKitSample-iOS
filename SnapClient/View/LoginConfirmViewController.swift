//
//  LoginConfirmViewController.swift
//  SnapClient
//
//  Created by Kei Fujikawa on 2018/07/01.
//  Copyright © 2018年 Kboy. All rights reserved.
//

import UIKit

class LoginConfirmViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var userEntity: UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.borderColor = UIColor.yellow.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true

        nameLabel.text = userEntity?.displayName
        
        goButton.setTitleColor(.black, for: .normal)
        goButton.backgroundColor = .yellow
        
        // set Image
        guard let avatarString = userEntity?.avatar else { return }
        avatarImageView.load(from: avatarString)
    }
    
    private func goToCamera(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        present(vc, animated: true, completion: nil)
    }

    @IBAction func goButtonTapped(_ sender: Any) {
        goToCamera()
    }
}
