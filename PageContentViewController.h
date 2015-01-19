//
//  PageContentViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *signPicker;
@property (weak, nonatomic) IBOutlet UILabel *horoscopeLabel;
@property (weak, nonatomic) IBOutlet UIView *previewView;

@property (nonatomic, assign) BOOL hidePicker;
@property (nonatomic, assign) BOOL presentCamera;

@property NSUInteger pageIndex;
@property NSString *horoscopeText;

@end
