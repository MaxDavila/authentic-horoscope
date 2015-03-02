//
//  UserHoroscope.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/22/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHoroscope : NSObject

+(UserHoroscope *)sharedInstance;
@property(nonatomic, strong) NSDictionary *snippetHoroscope;
@property(nonatomic, strong) NSString *fullHoroscope;
@property(nonatomic, strong) NSString *sign;
@property(nonatomic, strong, readonly) NSString *setSignPrompt;
@end
