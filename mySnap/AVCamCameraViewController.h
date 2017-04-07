/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	View controller for camera interface.
*/

@import UIKit;
@class AVCamPreviewView;
@protocol  AAPLCameraVCDelegate;


@interface AVCamCameraViewController : UIViewController
@property (nonatomic, weak) AVCamPreviewView *_previewView;

- (void)changeCamera;

- (void)toggleMovieRecording;

@property (retain) id <AAPLCameraVCDelegate> delegate;

@end
