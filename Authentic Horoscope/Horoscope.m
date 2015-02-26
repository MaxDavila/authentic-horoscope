//
//  Horoscope.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "Horoscope.h"
#include "SKPolygraph.h"

@implementation Horoscope {
    NSDictionary *_data;
    NSArray *_positiveWords;
    NSArray *_negativeWords;
}

+ (Horoscope *)sharedInstance {
    static Horoscope *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Horoscope alloc] init];
    });

    return _sharedInstance;
}

- (void)loadData:(NSDictionary *)data {
    _data = data;
    _positiveWords = [NSArray arrayWithObjects:@"Your day is gonna be fucking grrreat.",
                            @"Stars are aligning, go kick some balls.",
                            @"It’s gonna be amazeballs!!",
                            @"Today you are cleverly disguised as a responsible adult.",
                            @"Smile when things actually go fucking right today.",
                            @"Never pass up an opportunity to pee.",
                            @"Keep the dream alive. Hit the snooze button.",
                            @"Anything is possible if you don’t know what the fuck you are talking about.",
                            @"Remember: If you don’t sin, Jesus died for nothing.",
                            @"Always remember you’re unique. Just like everyone else.",
                            @"Don’t worry about the world coming to an end today. It’s already tomorrow in Hong Kong.",
                            @"A new pair of shoes will make your day less shitty.",
                            @"Today is probably a huge improvement over yesterday.",
                            @"Congratulations, you are not illiterate.",
                            @"You have some great fucking hindsight.",
                            @"You might use your brain today.",
                            @"You are not entirely worthless.",
                            @"Beer me, bro!",
                            // sticking neutral here as well
                            @"You will be hungry again in one hour.",
                            @"Practice safe eating. Always use condiments.",
                            @"Look before you leap! Or wear a parachute.",
                            @"If you’re not living on the edge, you’re taking up too much room.",
                            @"It’s not whether you win or lose, but how you place the blame.",
                            @"No one is listening until you fart.",
                            @"Don’t assume malice for what stupidity can explain.",

                            @"Just take the day off.", nil];

    _negativeWords = [NSArray arrayWithObjects:@"Your reality check is about to bounce.",
                            @"Drive like hell! You’re fucking late.",
                            @"You will soon have an out of money experience.",
                            @"A clear conscience is usually the sign of a bad memory.",
                            @"When opportunity knocks, don’t sit there complaining about the noise.",
                            @"Two wrongs are only the beginning.",
                      @"Two wrongs are only the beginning.",
                      @"The sooner you fall behind, the more time you’ll have to catch up.",
                      @"You will die alone and poorly dressed.",
                      @"Today your uselessness will surprise even your closest peers.",
                      @"Don’t bother going outside.",
                      @"You really shouldn’t believe in this shit.",
                      @"Don’t play the lottery today.",
                      @"Don't bother going outside", nil];

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
