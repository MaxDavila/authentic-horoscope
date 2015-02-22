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


#define BUTTON_VIEW_TAG_INDEX 5000

@interface SignsViewController ()

@property (nonatomic, strong) SignsView *signsView;

@end

@implementation SignsViewController

- (void)loadView
{
    self.signsView = [[SignsView alloc] init];

    for (int i = 0; i < 12; i++) {
        SignsButtonView *signButtonView = (SignsButtonView *)[self.signsView viewWithTag:(BUTTON_VIEW_TAG_INDEX + i)];
        [signButtonView.signButton addTarget:self action:@selector(signButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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


- (void)signButtonAction:(UIButton *)button
{
    int tag = (int)button.tag - BUTTON_VIEW_TAG_INDEX;
    SignsButtonView *signButtonView = (SignsButtonView *)[self.view viewWithTag:button.tag];
    NSLog(@"Tapped index %i sign %@", tag, signButtonView.signLabel.text);

    // Save selection to user defaults dict.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:signButtonView.signLabel.text forKey:@"sign"];
    [userDefaults synchronize];
    [self loadPrediction];
    
//    [self.parentViewController.parentViewController viewDidLoad];
}

- (void)loadPrediction {
    [HoroscopeApi getPredictionsFor:@"02/18/15" withSuccessBlock:^(NSDictionary *responseObject) {
        if (responseObject)
            [self showPrediction:responseObject];
    }];
}

- (void)showPrediction:(NSDictionary *)responseObject {
    
    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];

    Horoscope *horoscope = [Horoscope initWithData:responseObject];
    NSString *todayHoroscopeSnippet = [horoscope getSnippetForSign:sign];
        
    // Store the snippet prediction to be accessed later
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:todayHoroscopeSnippet forKey:@"predictionSnippet"];
}



@end
