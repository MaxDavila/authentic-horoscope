//
//  LandingViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "LandingViewController.h"

@interface LandingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *snippetPredictionLabel;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.snippetPredictionLabel.text = self.snippetText;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"yoooo");
    [super viewWillAppear:animated];
    NSString *predictionSnippet = [[NSUserDefaults standardUserDefaults] objectForKey:@"predictionSnippet"];
    
    self.snippetPredictionLabel.text = predictionSnippet;
    
}
@end
