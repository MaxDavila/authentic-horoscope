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
@property (weak, nonatomic) IBOutlet UILabel *signTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *signImageBlack;
@property (strong, nonatomic) IBOutlet UIImageView *signImageWhite;

@end

@implementation LandingViewController {
    NSString *labelSnippetText;
    NSString *labelFulltText;
    UIColor *textColor;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    self.fullPredictionLabel.alpha = 0;
    self.signImageWhite.alpha = 0;
    self.signTitleLabel.alpha = 0;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.signTitleLabel.frame = CGRectMake(self.fullPredictionLabel.frame.origin.x, self.fullPredictionLabel.frame.origin.y - 25.0f, self.fullPredictionLabel.frame.size.width, 25.0f);

}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // if showing snippet
    if (self.fullPredictionLabel.alpha == 0) {
        [UIView animateWithDuration:0.5 animations:^(void) {
            self.fullPredictionLabel.alpha = 1;
            self.signImageWhite.alpha = 1;
            self.signTitleLabel.alpha = 1;
            self.signImageBlack.alpha = 0;
            self.snippetPredictionLabel.alpha = 0;
            self.view.backgroundColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];

        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^(void) {
            self.snippetPredictionLabel.alpha = 1;
            self.signImageBlack.alpha = 1;
            self.fullPredictionLabel.alpha = 0;
            self.signImageWhite.alpha = 0;
            self.signTitleLabel.alpha = 0;

            self.view.backgroundColor = [UIColor colorWithRed:0.944 green:0.960 blue:0.964 alpha:1.000];
        }];

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
    if (userHoroscope.snippetHoroscope) {
        labelSnippetText = [userHoroscope.snippetHoroscope objectForKey:@"value"];
        labelFulltText = userHoroscope.fullHoroscope;
        textColor = [UIColor colorWithRed:0.260 green:0.260 blue:0.260 alpha:1.000];
        NSLog(@"sign: %@", userHoroscope.sign);
        NSLog(@"sign: %@", [userHoroscope.snippetHoroscope objectForKey:@"value"]);
        NSLog(@"sign: %@", userHoroscope.fullHoroscope);
        
        UIImage *blackSign = [UIImage imageNamed:[userHoroscope.sign stringByAppendingString:@"_icon_black_only"]];
        self.signImageBlack.image = blackSign;
        UIImage *whiteSign = [UIImage imageNamed:[userHoroscope.sign stringByAppendingString:@"_icon_white_only"]];
        self.signImageWhite.image = whiteSign;
        self.signTitleLabel.text = [userHoroscope.sign uppercaseString];
    }
    else {
        labelSnippetText = userHoroscope.setSignPrompt;
        labelFulltText = @"";
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
    NSMutableAttributedString *attrString = [AppManager buildAttributedStringfromText:labelSnippetText
                                                          withAttributes:attributes
                                                             toFitInSize:boundingViewSize
                                                             scaleFactor:scaleFactor];
    
    if (userHoroscope.snippetHoroscope) {
        NSRange range = [[userHoroscope.snippetHoroscope objectForKey:@"value"] rangeOfString:[userHoroscope.snippetHoroscope objectForKey:@"highlightedWord"] options:NSCaseInsensitiveSearch];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000] range:range];
    }
    
    self.snippetPredictionLabel.attributedText = attrString;
    self.fullPredictionLabel.text = labelFulltText;
}

@end
