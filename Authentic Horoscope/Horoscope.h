//
//  Horoscope.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Horoscope : NSObject

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *positiveWords;
@property (nonatomic, strong) NSArray *negativeWords;
@property (nonatomic, strong) NSArray *neutralSentences;

- (NSString *)getSnippetForSign:(NSString *)sign;
- (NSString *)getHoroscopeForSign:(NSString *)sign;

+ (instancetype)initWithData:(NSDictionary *)data;

@end
