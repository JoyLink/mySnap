//
//  UserVC.swift
//  mySnap
//
//  Created by Joy on 4/6/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class UserVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.userRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                                
                            }
                        }
                    }
                }
                self.tableView.reloadData()
            }
            
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selectd: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selectd: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
    @IBAction func sendPRPressed(_ sender: Any) {
        
        
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            let tast = ref.putFile(url, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print("Error uploading video: \(error?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else if let snapData = _snapData {
            let ref = DataService.instance.imagesStorageRef.child("\(NSUUID().uuidString).jpg")
            _ = ref.put(snapData, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    print ("Error uploading snap: \(error?.localizedDescription)")
                } else {
                    let downloadURL = meta?.downloadURL()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    

}
