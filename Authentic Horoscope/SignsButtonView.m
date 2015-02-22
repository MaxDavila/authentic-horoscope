//
//  LandingViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/18/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "SignsButtonView.h"

@implementation SignsButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        _animationView = [[CSAnimationView alloc] init];
//        _animationView.backgroundColor = [UIColor blackColor];
        _animationView.clipsToBounds = YES;
        _animationView.duration = 0.7;
        _animationView.delay    = 0;
        _animationView.type     = CSAnimationTypeMorph;
        [_animationView startCanvasAnimation];
        [self addSubview:_animationView];
        
        _signButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _signButton.backgroundColor = [UIColor whiteColor];
        _signButton.clipsToBounds = YES;
        [self.animationView addSubview:_signButton];
        
        _signLabel = [[UILabel alloc] init];
        _signLabel.numberOfLines = 1;
        _signLabel.adjustsFontSizeToFitWidth = YES;
        _signLabel.minimumScaleFactor = 0.5f;
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.fontName = @"BrandonGrotesque-Bold";
        [self addSubview:_signLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    CGFloat xOrigin = bounds.origin.x;
    CGFloat yOrigin = bounds.origin.y;
    
    CGFloat buttonWidthHeight = bounds.size.width / 1.5f;
    
    self.animationView.frame = CGRectMake((bounds.size.width - buttonWidthHeight) / 2.0f, (bounds.size.height - buttonWidthHeight) / 8.0f, buttonWidthHeight, buttonWidthHeight);

    self.signButton.frame = CGRectMake((self.animationView.bounds.size.width - buttonWidthHeight) / 2.0f, (self.animationView.bounds.size.height - buttonWidthHeight) / 3.0f, buttonWidthHeight, buttonWidthHeight);
    self.signButton.layer.cornerRadius = buttonWidthHeight / 2.0f;
    yOrigin += CGRectGetMaxY(self.signButton.frame);
    
    self.signLabel.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, bounds.size.height - yOrigin);
}

@end
