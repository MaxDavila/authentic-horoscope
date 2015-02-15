//
//  SettingsViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "SettingsViewController.h"
#import "CSAnimationView.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *signButtons;

@end

@implementation SettingsViewController {
    
    NSArray *_allSigns;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _allSigns = [NSArray arrayWithObjects:@"Aries",
                   @"Taurus",
                   @"Gemini",
                   @"Cancer",
                   @"Leo",
                   @"Virgo",
                   @"Libra",
                   @"Scorpio",
                   @"Sagittarius",
                   @"Capricorn",
                   @"Aquarius",
                   @"Pisces",nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.circleView startCanvasAnimation];

}

# pragma mark - actions
- (IBAction)signButtonTapped:(UIButton *)sender {
    NSUInteger chosenButton = [self.signButtons indexOfObject:sender];
    NSLog(@"button index: %lu", (unsigned long)chosenButton);
    
    // Save selection to user defaults dict.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_allSigns[chosenButton] forKey:@"sign"];
    [userDefaults synchronize];
    
    [self.parentViewController.parentViewController viewDidLoad];

}

@end
