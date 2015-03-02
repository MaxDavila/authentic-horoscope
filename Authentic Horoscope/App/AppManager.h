//
//  AppManager.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/26/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppManager : NSObject

+(AppManager *)sharedManager;
+(UIImage *)drawText:(NSString *)text inImage:(UIImage *)image withColor:(UIColor *)color;
+(NSMutableAttributedString *)buildAttributedStringfromText:(NSString *)text
                                      withAttributes:(NSDictionary *)attributes
                                         toFitInSize:(CGSize)boundingViewSize
                                         scaleFactor:(float)scaleFactor;
@end
