//
//  AVCamPreviewView.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/12/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface AVCamPreviewView : UIView

@property (nonatomic) AVCaptureSession *session;

@end