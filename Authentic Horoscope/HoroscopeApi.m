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

+ (void)getPredictionsFor:(NSString *)date withSuccessBlock:(responseSuccessBlock)successBlock {

    // Setup url
    NSString *urlString = @"http://www.findyourfate.com/rss/horoscope-astrology-feed.asp?mode=view&todate=1/16/2015";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *parsedResponse = [XMLParser getParsedResponse:responseObject];

        successBlock(parsedResponse);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
