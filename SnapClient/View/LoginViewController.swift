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
    
    private func goToLoginConfirm(_ entity: UserEntity){
        let storyboard = UIStoryboard(name: "LoginConfirm", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! LoginConfirmViewController
        vc.userEntity = entity
        present(vc, animated: true, completion: nil)
    }
    
    private func fetchSnapUserInfo(){
        let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
        
        SCSDKLoginClient
            .fetchUserData(
                withQuery: graphQLQuery,
                variables: nil,
                success: { userInfo in
                    
                    print(userInfo)
                    
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
}
