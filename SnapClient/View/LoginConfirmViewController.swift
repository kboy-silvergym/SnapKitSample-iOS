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
        guard let avatarString = userEntity?.avatar,
            let imageURL = URL(string: avatarString) else { return }
        do {
            let data = try Data(contentsOf: imageURL)
            let image = UIImage(data: data)
            avatarImageView.image = image
        } catch {
            
        }
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
