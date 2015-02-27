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
@property(nonatomic, weak) NSString *snippetHoroscope;
@property(nonatomic, weak) NSString *fullHoroscope;
@property(nonatomic, weak) NSString *sign;
@property(nonatomic, weak, readonly) NSString *setSignPrompt;
@end
