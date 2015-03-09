//
//  AppManager.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/26/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^successBlock)();
typedef void (^failureBlock)();

@interface AppManager : NSObject

+(AppManager *)sharedManager;
+(UIImage *)drawText:(NSString *)text inImage:(UIImage *)image withColor:(UIColor *)color;
+ (NSMutableAttributedString *)buildLabelAttributedTextWithText:(NSString *)text color:(UIColor *)color size:(CGSize)size;
+(NSString *)getFormattedDate;
+(void)checkConnectivity:(successBlock)successBlock failureBlock:(failureBlock)failureBlock;

@property (nonatomic, assign) BOOL isOnline;

@end

