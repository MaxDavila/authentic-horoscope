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
@property (weak, nonatomic) IBOutlet UILabel *fullPredictionLabel;

@end

@implementation LandingViewController {
    NSString *labelText;
    UIColor *textColor;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    self.fullPredictionLabel.alpha = 0;

    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // if showing snippet
    if (self.fullPredictionLabel.alpha == 0) {
        [UIView animateWithDuration:0.5 animations:^(void) {
            self.fullPredictionLabel.alpha = 1;
            self.snippetPredictionLabel.alpha = 0;
            self.view.backgroundColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];

        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^(void) {
            self.snippetPredictionLabel.alpha = 1;
            self.fullPredictionLabel.alpha = 0;
            self.view.backgroundColor = [UIColor colorWithRed:0.944 green:0.960 blue:0.964 alpha:1.000];
        }];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
    if (userHoroscope.snippetHoroscope) {
        labelText = userHoroscope.snippetHoroscope;
        textColor = [UIColor colorWithRed:0.260 green:0.260 blue:0.260 alpha:1.000];
    }
    else {
        labelText = userHoroscope.setSignPrompt;
        textColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];
    }
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
    self.fullPredictionLabel.text = userHoroscope.fullHoroscope;
}

@end
