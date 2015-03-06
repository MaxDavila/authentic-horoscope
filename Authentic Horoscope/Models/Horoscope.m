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
    NSArray *_positiveSentences;
    NSArray *_negativeSentences;
}

+ (Horoscope *)sharedInstance {
    static Horoscope *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Horoscope alloc] init];
    });

    return _sharedInstance;
}

- (void)loadData:(NSDictionary *)data withSuccessBlock:(successBlock)successBlock withFailureBlock:(failureBlockWithError)failureBlock {

    // Check if we get full horoscope from the API
    if ([data count] > 12) {
        _data = data;
        _positiveSentences = [self loadDictionaryFromFile:@"positive-sentences"];
        _negativeSentences = [self loadDictionaryFromFile:@"negative-sentences"];
        successBlock();
    }
    else {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"There was an error getting your Authentic Horoscope.",
                                   NSLocalizedFailureReasonErrorKey: @"API data is corrupted.",
                                   NSLocalizedRecoverySuggestionErrorKey: @"Have you tried turning it off and on again?"};
        
        NSError *error = [NSError errorWithDomain:@"HoroscopeErrorDomain"
                                             code:1000
                                         userInfo:userInfo];
        failureBlock(error);
    }
}

- (NSDictionary *)getSnippetForSign:(NSString *)sign {
    float score = [self getScoreForSign:sign];
    
    if (score > 2) {
        int r = arc4random_uniform((int)[_positiveSentences count]);
        return [_positiveSentences objectAtIndex:r];
    }
    else {
        int r = arc4random_uniform((int)[_negativeSentences count]);
        return [_negativeSentences objectAtIndex:r];
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

- (NSDictionary *)getOfflinePrediction {
    NSDictionary *offlinePrediction = @{@"value": @"Someone broke the internet :(",
                                        @"highlightedWord": @"broke"};
    return offlinePrediction;
}

# pragma mark - file parsing

- (NSArray*)loadDictionaryFromFile:(NSString*)filename {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:filename
                                                     ofType:@"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    
    if (!error) {
        NSArray *items = [content componentsSeparatedByString:@"\n"];
        if (items) {
            NSString *sentence = nil;
            NSString *highlightedWord = nil;

            for (NSString *item in items) {
                if ([item length] > 0) {
                    if (![[item substringToIndex:1] isEqualToString:@";"] &&
                        ![[item substringToIndex:1] isEqualToString:@"\n"]) {

                        if (sentence == nil) {
                            sentence = item;
                        }
                        else {
                            highlightedWord = item;
                            NSDictionary *dict = @{@"value":sentence, @"highlightedWord":highlightedWord};
                            [result addObject:dict];
                            
                            sentence = nil;
                            highlightedWord = nil;
                        }
                    }
                }
            }
        }
    }
    
    return [NSArray arrayWithArray:result];
}

@end
