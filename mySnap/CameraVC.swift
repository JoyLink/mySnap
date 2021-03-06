//
//  ViewController.swift
//  mySnap
//
//  Created by Joy on 3/20/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import FirebaseAuth


class CameraVC: AVCamCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var previewView: AVCamPreviewView!
    override func viewDidLoad() {
        
        
        self._previewView = previewView
        
        delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        try! FIRAuth.auth()!.signOut()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }

   
    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }

    @IBAction func switchBtnPressed(_ sender: Any) {
        changeCamera()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoURL"]
                userVC.videoURL = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                userVC.snapData = snapData
            }
        }
    }
    

    func videoRecordingComplete(_ videoURL: URL!) {
        performSegue(withIdentifier: "UserVC", sender: ["videoURL":videoURL])
    }
    
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: "UserVC", sender: ["snapshotData":snapshotData])
    }
    

}

