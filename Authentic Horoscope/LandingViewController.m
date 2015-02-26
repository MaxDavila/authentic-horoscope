//
//  LandingViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "LandingViewController.h"
#import "UserHoroscope.h"
#import "AppManager.h"

@interface LandingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *snippetPredictionLabel;

@end

@implementation LandingViewController {
    NSString *labelText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
    if (userHoroscope.snippetHoroscope) {
        labelText = userHoroscope.snippetHoroscope;
    }
    else {
        labelText = @"Go set your sign son!";

    }
    UIColor *textColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    float fontSize = 120.0f;
    UIFont *font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:fontSize];

    paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: textColor,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName: font};
    CGSize boundingViewSize = CGSizeMake(self.view.bounds.size.width * .90f, (self.view.bounds.size.height - (self.view.bounds.size.height / 2)));
    float scaleFactor = .99f;
    NSAttributedString *attrString = [AppManager buildAttributedStringfromText:labelText
                                                          withAttributes:attributes
                                                             toFitInSize:boundingViewSize
                                                             scaleFactor:scaleFactor];
    self.snippetPredictionLabel.attributedText = attrString;
}

@end
