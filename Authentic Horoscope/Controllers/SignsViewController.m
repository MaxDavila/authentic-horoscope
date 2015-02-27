//
//  LandingViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/18/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "SignsViewController.h"
#import "SignsView.h"
#import "Canvas.h"
#import "HoroscopeApi.h"
#import "Horoscope.h"
#import "UserHoroscope.h"


#define BUTTON_VIEW_TAG_INDEX 5000

@interface SignsViewController ()

@property (nonatomic, strong) SignsView *signsView;

@end

@implementation SignsViewController

- (void)loadView {
    self.signsView = [[SignsView alloc] init];

    for (int i = 0; i < 12; i++) {
        SignsButtonView *signButtonView = (SignsButtonView *)[self.signsView viewWithTag:(BUTTON_VIEW_TAG_INDEX + i)];
        [signButtonView.signButton addTarget:self action:@selector(updateHoroscope:) forControlEvents:UIControlEventTouchUpInside];
    }

    self.view = self.signsView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i = 0; i < 12; i++) {
        SignsButtonView *signButtonView = (SignsButtonView *)[self.signsView viewWithTag:(BUTTON_VIEW_TAG_INDEX + i)];
        [signButtonView.animationView startCanvasAnimation];
    }
}

- (void)updateHoroscope:(UIButton *)button {
    SignsButtonView *signButtonView = (SignsButtonView *)[self.view viewWithTag:button.tag];
    NSString *sign = signButtonView.signLabel.text;
    NSLog(@"hit %@", sign);

    // Save selection to user defaults dict.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:sign forKey:@"sign"];
    [userDefaults synchronize];
    
    // Update user horoscope
    Horoscope *horoscope = [Horoscope sharedInstance];
    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];

    userHoroscope.snippetHoroscope = [horoscope getSnippetForSign:sign];
    userHoroscope.fullHoroscope = [horoscope getHoroscopeForSign:sign];
    userHoroscope.sign = sign;

}

@end
