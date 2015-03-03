//
//  UserHoroscope.m
//  Authentic Horoscope
//
//  Created by Max Davila on 2/22/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "UserHoroscope.h"

@implementation UserHoroscope

+ (UserHoroscope *)sharedInstance {
    static UserHoroscope *_sharedInstance;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UserHoroscope alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _setSignPrompt = @"Swipe right to set your sign son!";
    }
    return self;
}

- (void)update:(Horoscope *)horoscope forSign:(NSString *)sign {
    self.snippetHoroscope = [horoscope getSnippetForSign:sign];
    self.fullHoroscope = [horoscope getHoroscopeForSign:sign];
    self.sign = sign;
}

@end
