//
//  LandingViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "LandingViewController.h"
#import "UserHoroscope.h"

@interface LandingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *snippetPredictionLabel;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
    if (userHoroscope.snippetHoroscope) {
        self.snippetPredictionLabel.text = userHoroscope.snippetHoroscope;
    }
    else {
        self.snippetPredictionLabel.text = @"Go set your sign son!";
    }
}
@end
