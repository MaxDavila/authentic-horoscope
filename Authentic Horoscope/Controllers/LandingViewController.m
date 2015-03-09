//
//  MiddleViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 3/7/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "LandingViewController.h"
#import "HoroscopeView.h"
#import "UserHoroscope.h"
#import "AppManager.h"

@interface LandingViewController ()

@property (nonatomic, strong) HoroscopeView *horoscopeView;

@end

@implementation LandingViewController  {
    NSString *labelFulltText;
    NSMutableAttributedString *attrString;
    SnippetHoroscopeView *snippetView;
    FullHoroscopeView *fullHoroscopeView;
    UserHoroscope *userHoroscope;
}

- (void)loadView
{
    self.horoscopeView = [[HoroscopeView alloc] init];
    self.view = self.horoscopeView;

    snippetView = self.horoscopeView.snippetView;
    fullHoroscopeView = self.horoscopeView.fullHoroscopeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userHoroscope = [UserHoroscope sharedInstance];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    [self.view addGestureRecognizer:longPress];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sign"]) {
        [self refreshViewContents];
    }
    else {
        [self firstTimeSetup];
    }

    fullHoroscopeView.alpha = 0;
    snippetView.label.alpha = 0;
    snippetView.label.frame = CGRectMake(snippetView.label.frame.origin.x, self.view.frame.size.height, snippetView.label.frame.size.width, snippetView.label.frame.size.height);
}

- (void)viewDidLayoutSubviews {
    [UIView animateWithDuration:0.8 animations:^(void) {
        snippetView.label.alpha = 1;
        snippetView.label.frame = CGRectMake(snippetView.label.frame.origin.x, self.view.frame.origin.y, snippetView.label.frame.size.width, snippetView.label.frame.size.height);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (userHoroscope.changed) {
        [self refreshViewContents];
        userHoroscope.changed = NO;
    }

    snippetView.label.attributedText = attrString;
    fullHoroscopeView.horoscopeLabel.text = labelFulltText;
    
}

# pragma mark - helper methods

- (void)refreshViewContents {
    NSString *snippetText = [userHoroscope.snippetHoroscope objectForKey:@"value"];
    UIColor *snippetTextColor = [UIColor colorWithRed:0.260 green:0.260 blue:0.260 alpha:1.000];
    CGSize size = CGSizeMake(self.view.bounds.size.width * .90f, self.view.bounds.size.height * .50f);
    attrString = [AppManager buildLabelAttributedTextWithText:snippetText color:snippetTextColor size:size];

    labelFulltText = userHoroscope.fullHoroscope;
    fullHoroscopeView.titleLabel.text = [userHoroscope.sign uppercaseString];
    
    // Highlight word
    NSRange range = [[userHoroscope.snippetHoroscope objectForKey:@"value"] rangeOfString:[userHoroscope.snippetHoroscope objectForKey:@"highlightedWord"] options:NSCaseInsensitiveSearch];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000] range:range];
    
    // Set sign images
    UIImage *blackSign = [UIImage imageNamed:[userHoroscope.sign stringByAppendingString:@"_icon_black_only"]];
    snippetView.signImage.image = blackSign;
    UIImage *whiteSign = [UIImage imageNamed:[userHoroscope.sign stringByAppendingString:@"_icon_white_only"]];
    fullHoroscopeView.signImage.image = whiteSign;
}

- (void)firstTimeSetup {
    labelFulltText = @"";
    UIColor *color = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];
    CGSize size = CGSizeMake(self.view.bounds.size.width * .90f, self.view.bounds.size.height * .50f);
    attrString = [AppManager buildLabelAttributedTextWithText:userHoroscope.setSignPrompt color:color size:size];
}

# pragma mark - gesture handlers

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // if showing snippet
    if (fullHoroscopeView.alpha == 0) {
        [UIView animateWithDuration:0.5 animations:^(void) {
            fullHoroscopeView.alpha = 1;
            snippetView.alpha = 0;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^(void) {
            snippetView.alpha = 1;
            fullHoroscopeView.alpha = 0;
        }];
        
    }
}
@end
