//
//  UserHoroscope.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/22/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Horoscope.h"

@interface UserHoroscope : NSObject

+(UserHoroscope *)sharedInstance;
-(void)update:(Horoscope *)horoscope forSign:(NSString *)sign;

@property(nonatomic, strong) NSDictionary *snippetHoroscope;
@property(nonatomic, strong) NSString *fullHoroscope;
@property(nonatomic, strong) NSString *sign;
@property(nonatomic, strong, readonly) NSString *setSignPrompt;
@end
