//
//  DataService.swift
//  mySnap
//
//  Created by Joy on 4/6/17.
//  Copyright © 2017 me. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    
    var userRef: FIRDatabaseReference {
        return mainRef.child("users")
    }
    
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        mainRef.child("Users").child(uid).child("profile").setValue(profile)
    }
}
