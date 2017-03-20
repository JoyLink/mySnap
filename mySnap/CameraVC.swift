//
//  ViewController.swift
//  mySnap
//
//  Created by Joy on 3/20/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit


class CameraVC: AVCamCameraViewController {

    @IBOutlet weak var previewView: AVCamPreviewView!
    override func viewDidLoad() {
        
        self._previewView = previewView
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

   
    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }

    @IBAction func switchBtnPressed(_ sender: Any) {
        changeCamera()
    }


}

