//
//  AuthService.swift
//  mySnap
//
//  Created by Joy on 4/5/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instanct: AuthService {
        return _instance
    }
    
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errorcode = FIRAuthErrorCode(rawValue: (error! as NSError).code) {
                    if errorcode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                            } else {
                                if user?.uid != nil {
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                                        } else {
                                            onComplete!(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    self.handleFirebaseError(error: error as! NSError, onComplete: onComplete!)
                }
            } else {
                onComplete?( nil, user)
            }
            
        })
    }


    func handleFirebaseError(error: NSError, onComplete: Completion) {
        print(error.description)
        if let errorcode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorcode {
            case .errorCodeInvalidEmail:
                onComplete("Invalide Email", nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Invalide Password", nil)
                break
                
            case .errorCodeEmailAlreadyInUse:
                onComplete("Email already in use", nil)
                break
            default:
                onComplete("There was a problem authenticating, Try again", nil)
                break
            }
        }
    }



}
