//
//  SettingsViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *signPicker;
@property (weak, nonatomic) IBOutlet UIView *circleView;

- (IBAction)button:(id)sender;

@end
