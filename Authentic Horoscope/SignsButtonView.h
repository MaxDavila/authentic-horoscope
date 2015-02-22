//
//  LandingViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/18/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface SignsButtonView : UIView

@property (nonatomic, strong) UIButton *signButton;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) CSAnimationView *animationView;

@end
