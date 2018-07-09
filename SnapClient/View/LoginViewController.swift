//
//  LoginViewController.swift
//  SnapClient
//
//  Created by Kei Fujikawa on 2018/06/15.
//  Copyright © 2018年 Kboy. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Try to login. If you haven't requested yet, userEntity will be nil.
        self.fetchSnapUserInfo({ (userEntity, error) in
            
            if let userEntity = userEntity {
                DispatchQueue.main.async {
                    self.goToLoginConfirm(userEntity)
                }
            }
        })
    }
    
    // go to next ViewController
    private func goToLoginConfirm(_ entity: UserEntity){
        let storyboard = UIStoryboard(name: "LoginConfirm", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! LoginConfirmViewController
        vc.userEntity = entity
        present(vc, animated: true, completion: nil)
    }
    
    // request UserInfo to SnapSDK.
    // If you haven't requested yet, it will jump to the SnapChat app and get auth.
    private func fetchSnapUserInfo(_ completion: @escaping ((UserEntity?, Error?) -> ())){
        let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
        
        SCSDKLoginClient
            .fetchUserData(
                withQuery: graphQLQuery,
                variables: nil,
                success: { userInfo in
                    
                    if let userInfo = userInfo,
                        let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted),
                        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: data) {
                        completion(userEntity, nil)
                    }
            }) { (error, isUserLoggedOut) in
                completion(nil, error)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        SCSDKLoginClient.login(from: self, completion: { success, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if success {
                self.fetchSnapUserInfo({ (userEntity, error) in
                    
                    if let userEntity = userEntity {
                        DispatchQueue.main.async {
                            self.goToLoginConfirm(userEntity)
                        }
                    }
                })
            }
        })
    }
}
