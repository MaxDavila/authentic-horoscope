//
//  Horoscope.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Horoscope : NSObject

- (NSDictionary *)getSnippetForSign:(NSString *)sign;
- (NSString *)getHoroscopeForSign:(NSString *)sign;

- (void)loadData:(NSDictionary *)data;
+ (Horoscope *) sharedInstance;
@end
