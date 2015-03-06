//
//  HoroscopeApi.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/20/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^responseSuccessBlock)(NSDictionary *responseObject);
typedef void (^failureBlockWithError)(NSError *error);

@interface HoroscopeApi : NSObject

+ (void)getPredictionsFor:(NSString *)date withSuccessBlock:(responseSuccessBlock)successBlock withFailureBlock:(failureBlockWithError)failureBlock;

@end
