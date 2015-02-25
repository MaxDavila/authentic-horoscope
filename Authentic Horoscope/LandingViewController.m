//
//  LandingViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/19/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "LandingViewController.h"
#import "UserHoroscope.h"

@interface LandingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *snippetPredictionLabel;

@end

@implementation LandingViewController {
    NSString *labelText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
    if (userHoroscope.snippetHoroscope) {
        labelText = userHoroscope.snippetHoroscope;
    }
    else {
        labelText = @"Go set your sign son!";

    }
    
    UIColor *textColor = [UIColor colorWithRed:0.161 green:0.733 blue:0.612 alpha:1.000];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    float fontSize = 60.0f;
    UIFont *font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:fontSize];

    paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName: textColor,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSFontAttributeName: font};
    CGSize boundingViewSize = CGSizeMake(self.view.bounds.size.width - 60, (self.view.bounds.size.height - (self.view.bounds.size.height / 2)));
    float scaleFactor = .99f;
    NSAttributedString *attrString = [self buildAttributedStringfromText:labelText
                                                          withAttributes:attributes
                                                             toFitInSize:boundingViewSize
                                                             scaleFactor:scaleFactor];
    self.snippetPredictionLabel.attributedText = attrString;
}

- (NSAttributedString *)buildAttributedStringfromText:(NSString *)text
                                       withAttributes:(NSDictionary *)attributes
                                          toFitInSize:(CGSize)boundingViewSize
                                          scaleFactor:(float)scaleFactor {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttributes:attributes range:NSMakeRange(0, [text length])];
    
    CGSize rect = CGSizeMake(boundingViewSize.width, CGFLOAT_MAX);
    CGRect stringRect = [attributedString boundingRectWithSize:rect options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    // Get current font size
    UIFont *font = attributes[NSFontAttributeName];
    UIFontDescriptor *fontProperties = font.fontDescriptor;
    NSNumber *sizeNumber = fontProperties.fontAttributes[UIFontDescriptorSizeAttribute];
    float fontSize = [sizeNumber floatValue];
    
    NSMutableParagraphStyle *paragraphStyle = attributes[NSParagraphStyleAttributeName];

    while (boundingViewSize.height <= stringRect.size.height) {
        fontSize = fontSize * scaleFactor;

        font = [font fontWithSize:fontSize];
        paragraphStyle.maximumLineHeight = fontSize + fontSize * .10f;
        
        [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [text length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        
        stringRect = [attributedString boundingRectWithSize:rect options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];

    }
    return attributedString;
}

@end
