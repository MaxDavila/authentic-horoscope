//
//  HoroscopeView.h
//  Authentic Horoscope
//
//  Created by Max Davila on 3/8/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnippetHoroscopeView.h"
#import "FullHoroscopeView.h"

@interface HoroscopeView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) SnippetHoroscopeView *snippetView;
@property (nonatomic, strong) FullHoroscopeView *fullHoroscopeView;

@end
