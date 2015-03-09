//
//  AppManager.m
//  Authentic Horoscope
//
//  Created by Max Davila on 2/26/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "AppManager.h"
#import <Reachability/Reachability.h>

@implementation AppManager

+ (AppManager *)sharedManager {
    static AppManager *_sharedManager;
    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[AppManager alloc] init];
    });

    return _sharedManager;
}

+ (void)checkConnectivity:(successBlock)successBlock failureBlock:(failureBlock)failureBlock {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
            successBlock();
        });
    };
    
    // Internet is not reachable
    reach.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet!");
            failureBlock();
        });
    };
    [reach startNotifier];
}

+ (NSMutableAttributedString *)buildLabelAttributedTextWithText:(NSString *)text color:(UIColor *)color size:(CGSize)size {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    float fontSize = 120.0f;
    UIFont *font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:fontSize];
    
    paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: color,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName: font};
    
    float scaleFactor = .99f;
    return [self buildAttributedStringfromText:text
                                      withAttributes:attributes
                                         toFitInSize:size
                                         scaleFactor:scaleFactor];
}

+ (NSMutableAttributedString *)buildAttributedStringfromText:(NSString *)text
                                       withAttributes:(NSDictionary *)attributes
                                          toFitInSize:(CGSize)desiredBoundingSize
                                          scaleFactor:(float)scaleFactor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:attributes range:NSMakeRange(0, [text length])];

    // Get size of attributed string with the current font size
    CGSize maxSize = CGSizeMake(desiredBoundingSize.width, CGFLOAT_MAX);
    CGRect stringRect = [attributedString boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    // Get current font size
    UIFont *font = attributes[NSFontAttributeName];
    UIFontDescriptor *fontProperties = font.fontDescriptor;
    NSNumber *sizeNumber = fontProperties.fontAttributes[UIFontDescriptorSizeAttribute];
    float fontSize = [sizeNumber floatValue];
    
    NSMutableParagraphStyle *paragraphStyle = attributes[NSParagraphStyleAttributeName];
    
    // Decrease the fontsize by the scaling factor while the desired
    // boundingViewSize is <= than the size needed to draw the attributed string
    while (desiredBoundingSize.height <= stringRect.size.height) {
        fontSize = fontSize * scaleFactor;
        
        font = [font fontWithSize:fontSize];
        paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
        
        [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [text length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        
        stringRect = [attributedString boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
        
    }
    return attributedString;
}

+ (UIImage*)drawText:(NSString*)text
            inImage:(UIImage*)image
          withColor:(UIColor *)color
{
    UIColor *textColor = color;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    float fontSize = 360.0f;
    UIFont *font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:fontSize];
    paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: textColor,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName: font};
    
    CGSize boundingViewSize = CGSizeMake(image.size.width * .90f, (image.size.height - image.size.height / 2));
    float scaleFactor = .90f;
    NSMutableAttributedString *attrString = [AppManager buildAttributedStringfromText:text
                                                                withAttributes:attributes
                                                                   toFitInSize:boundingViewSize
                                                                   scaleFactor:scaleFactor];
    
    CGSize imageSize = CGSizeMake(image.size.width * .90f, CGFLOAT_MAX);
    CGRect stringRect = [attrString boundingRectWithSize:imageSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    CGFloat yOrigin = (image.size.height - stringRect.size.height) / 2;
    CGRect rect = CGRectMake(image.size.width * .05f, yOrigin, image.size.width * .90f, image.size.height);
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [attrString drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (NSString *)getFormattedDate {
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
    
    return localDateString;
}
@end
