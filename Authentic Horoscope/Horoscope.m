//
//  Horoscope.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "Horoscope.h"
#include "SKPolygraph.h"

@implementation Horoscope

+ (instancetype)initWithData:(NSDictionary *)data {
    return [[Horoscope alloc] initWithData:data];
}

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
        _positiveWords = [NSArray arrayWithObjects:@"It's gonna be amazeballs",
                          @"Your day is gonna be fucking grrreat",
                          @"Stars are aligning, go kick some balls",
                          @"You are fucking Beyoncé today", nil];
        _negativeWords = [NSArray arrayWithObjects:@"Don't play the lottery today",
                          @"Kicking donkey balls",
                          @"Don't talk to anyone with a fucking fedora today or you'll regret it",
                          @"Don't bother going outside", nil];
    }
    return self;
}

- (NSString *)getSnippetForSign:(NSString *)sign {
    float score = [self getScoreForSign:sign];
    
    if (score > 2) {
        int r = arc4random_uniform((int)[_positiveWords count]);
        return [_positiveWords objectAtIndex:r];
    }
    else {
        int r = arc4random_uniform((int)[_negativeWords count]);
        return [_negativeWords objectAtIndex:r];
    }
}

- (float)getScoreForSign:(NSString *)sign {
    NSString *forecast = [self getHoroscopeForSign:sign];

    float score = [[SKPolygraph sharedInstance] analyseSentiment:forecast];
    return score;
}

- (NSString *)getHoroscopeForSign:(NSString *)sign {
    return [_data objectForKey:sign];
}

@end
