//
//  SnippetHoroscopeView.m
//  Authentic Horoscope
//
//  Created by Max Davila on 3/7/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "SnippetHoroscopeView.h"

@implementation SnippetHoroscopeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.944 green:0.960 blue:0.964 alpha:1.000];
        
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        [self addSubview:_label];

        _signImage = [[UIImageView alloc] init];
        _signImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_signImage];
    }
    return self;
}

- (void)layoutSubviews {
//    [super layoutSubviews];

    CGRect bounds = self.bounds;
    CGRect insetBounds = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f));
    CGFloat xOrigin = insetBounds.origin.x;
    CGFloat yOrigin = insetBounds.origin.y;

    float imageWidthHeight = 40.f;
    
    self.label.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, insetBounds.size.height - imageWidthHeight);
    yOrigin += self.label.frame.size.height;

    self.signImage.frame = CGRectMake(xOrigin, yOrigin, imageWidthHeight, imageWidthHeight);
}

@end
