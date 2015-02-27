//
//  LandingViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/18/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "SignsView.h"

#define BUTTON_VIEW_TAG_INDEX 5000

@implementation SignsView {
    NSArray *_allSigns;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
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

        self.backgroundColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Hurry up and pick a sign";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.fontName = @"BrandonGrotesque-Bold";
        [self addSubview:_titleLabel];
     
        // Add all buttonViews to view
        for (int i = 0; i < [_allSigns count]; i++) {
            SignsButtonView *buttonView = [self buttonViewWithTitle:_allSigns[i]];
            buttonView.tag = BUTTON_VIEW_TAG_INDEX + i;
            buttonView.signButton.tag = BUTTON_VIEW_TAG_INDEX + i;

            [self addSubview:buttonView];
        }
        
        _creditsView = [[UIView alloc] init];
        _creditsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_creditsView];
        
        _creditsLabel = [[UILabel alloc] init];
        _creditsLabel.text = @"Made with so much hate in California by Max & Micaela";
        _creditsLabel.numberOfLines = 1;
        _creditsLabel.textColor = [UIColor blackColor];
//        _creditsLabel.backgroundColor = [UIColor redColor];

        _creditsLabel.fontName = @"BrandonGrotesque-Medium";
        _creditsLabel.adjustsFontSizeToFitWidth = YES;
        _creditsLabel.minimumScaleFactor = 0.5f;
        _creditsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_creditsLabel];

    }
    return self;
}

- (SignsButtonView *)buttonViewWithTitle:(NSString *)title
{
    SignsButtonView *buttonView = [[SignsButtonView alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon_black", title]];
    buttonView.signLabel.text = title;
    [buttonView.signButton setImage: [buttonImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] forState: UIControlStateNormal];
    
    return buttonView;
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    CGRect insetBounds = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(30.0f, 30.0f, 30.0f, 30.0f));
    CGFloat xOrigin = insetBounds.origin.x;
    CGFloat yOrigin = insetBounds.origin.y;
    
    self.titleLabel.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, 50.0f);
    
    yOrigin += CGRectGetHeight(self.titleLabel.frame);
    
    CGFloat padding = 5.0f;
    CGFloat buttonWidth = (insetBounds.size.width - padding * 2.0f) / 3.0f;
    CGFloat buttonHeight = (insetBounds.size.height - padding * 3.0f - yOrigin) / 4.0f;
    
    // Layout button views
    for (int i = 0; i < [_allSigns count]; i++) {
        SignsButtonView *signButtonView = (SignsButtonView *)[self viewWithTag:(BUTTON_VIEW_TAG_INDEX + i)];
        signButtonView.frame = CGRectMake(xOrigin, yOrigin, buttonWidth, buttonHeight);

        // If at the end of the row, update the Ycoordinate.
        if ((i +1) % 3 == 0) {
            yOrigin += buttonHeight + padding;
            xOrigin = insetBounds.origin.x;
        }
        else {
            xOrigin += buttonWidth + padding;
        }
        
    }

    self.creditsView.frame = CGRectMake(0.0, yOrigin, bounds.size.width, bounds.size.height - yOrigin);
    
    CGRect creditsViewBounds = self.creditsView.bounds;
    yOrigin += (creditsViewBounds.size.height - creditsViewBounds.size.height / 3.0f)/ 2.0f;

    self.creditsLabel.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width - xOrigin * 2.0f, creditsViewBounds.size.height / 3.5f);
    
}

@end
