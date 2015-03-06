//
//  HoroscopeApi.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/20/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "HoroscopeApi.h"
#import "XMLParser.h"
#import <AFNetworking/AFNetworking.h>

@implementation HoroscopeApi

+ (void)getPredictionsFor:(NSString *)date withSuccessBlock:(responseSuccessBlock)successBlock withFailureBlock:(failureBlockWithError)failureBlock {

    // Setup url
    NSString *baseUrl = @"http://www.findyourfate.com/rss/horoscope-astrology-feed.asp?mode=view&todate=";
    NSString *urlString = [baseUrl stringByAppendingString:date];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *parsedResponse = [XMLParser getParsedResponse:responseObject];

        successBlock(parsedResponse);
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"There was an error getting your Authentic Horoscope.",
                                   NSLocalizedFailureReasonErrorKey: err.localizedDescription,
                                   NSLocalizedRecoverySuggestionErrorKey: @"Please try again in a few minutes."};
        
        NSError *error = [NSError errorWithDomain:@"HoroscopeApiErrorDomain"
                                             code:1010
                                         userInfo:userInfo];
        failureBlock(error);
    }];
}
@end
