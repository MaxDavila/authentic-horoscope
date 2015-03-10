//
//  ViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Horoscope.h"
#import "HoroscopeApi.h"
#import "SignsViewController.h"

@interface ViewController : UIViewController <SignsViewControllerDelegate>

@property (strong, nonatomic) NSString *todayHoroscope;
@property (strong, nonatomic) NSString *birthdate;

@end

