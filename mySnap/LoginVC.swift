//
//  LoginVC.swift
//  mySnap
//
//  Created by Joy on 4/5/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var password: RoundTextField!
    @IBOutlet weak var email: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let eml = email.text , let pwd = password.text, (eml.characters.count > 0 && pwd.characters.count > 0) {
            
            AuthService.instanct.login(email: eml, password: pwd, onComplete: { (errMsg, data) in
                
            })
            
        } else {
            let alert = UIAlertController(title: "User name and password required", message: "You must enter both the user name and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
    }


}
