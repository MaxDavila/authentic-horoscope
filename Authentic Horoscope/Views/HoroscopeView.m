//
//  HoroscopeView.m
//  Authentic Horoscope
//
//  Created by Max Davila on 3/8/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "HoroscopeView.h"

@implementation HoroscopeView

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _snippetView = [[SnippetHoroscopeView alloc] init];
        [self addSubview:_snippetView];
        
        _fullHoroscopeView = [[FullHoroscopeView alloc] init];
        [self addSubview:_fullHoroscopeView];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    CGFloat xOrigin = bounds.origin.x;
    CGFloat yOrigin = bounds.origin.y;
    
    self.snippetView.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, bounds.size.height);
    self.fullHoroscopeView.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, bounds.size.height);

}


@end
