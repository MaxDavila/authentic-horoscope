//
//  Horoscope.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)();
typedef void (^failureBlockWithError)(NSError *error);

@interface Horoscope : NSObject

- (NSDictionary *)getSnippetForSign:(NSString *)sign;
- (NSString *)getHoroscopeForSign:(NSString *)sign;

- (void)loadData:(NSDictionary *)data;
- (void)loadData:(NSDictionary *)data withSuccessBlock:(successBlock)successBlock withFailureBlock:(failureBlockWithError)failureBlock;

- (NSDictionary *)getOfflinePrediction;
+ (Horoscope *) sharedInstance;
@end
