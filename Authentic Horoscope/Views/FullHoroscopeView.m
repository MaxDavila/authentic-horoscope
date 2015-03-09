//
//  FullHoroscopeView.m
//  Authentic Horoscope
//
//  Created by Max Davila on 3/8/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "FullHoroscopeView.h"

@implementation FullHoroscopeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:22.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _horoscopeLabel = [[UILabel alloc] init];
        _horoscopeLabel.numberOfLines = 0;
        _horoscopeLabel.adjustsFontSizeToFitWidth = YES;
        _horoscopeLabel.minimumScaleFactor = 0.5f;
        _horoscopeLabel.textColor = [UIColor whiteColor];
        _horoscopeLabel.textAlignment = NSTextAlignmentLeft;
        _horoscopeLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:25.0];
        [self addSubview:_horoscopeLabel];

        _signImage = [[UIImageView alloc] init];
        _signImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_signImage];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    CGRect insetBounds = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(50.0f, 20.0f, 20.0f, 20.0f));
    CGFloat xOrigin = insetBounds.origin.x;
    CGFloat yOrigin = insetBounds.origin.y;
    float imageWidthHeight = 40.f;
    float padding = 10.f;
    
    self.titleLabel.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, 30.f);
    yOrigin += self.titleLabel.frame.size.height;
    
    self.horoscopeLabel.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width - 20.f, insetBounds.size.height - self.titleLabel.frame.size.height - imageWidthHeight - padding);
    yOrigin += self.horoscopeLabel.frame.size.height + padding;
    
    self.signImage.frame = CGRectMake(xOrigin, yOrigin, imageWidthHeight, imageWidthHeight);
}

@end
