//
//  PageContentViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation PageContentViewController  {
    NSArray *_pickerData;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.horoscopeLabel.text = self.horoscopeText;
    _pickerData = [NSArray arrayWithObjects:@"Aries",
                    @"Taurus",
                    @"Gemini",
                    @"Cancer",
                    @"Leo",
                    @"Virgo",
                    @"Libra",
                    @"Scorpio",
                    @"Sagittarius",
                    @"Capricorn",
                    @"Aquarius",
                    @"Pisces",nil];
    
    // Connect data
    self.signPicker.dataSource = self;
    self.signPicker.delegate = self;
    self.signPicker.hidden = self.hidePicker;
    NSLog(@"pagecontroller view %@", self.signPicker);

}

- (void)viewDidAppear:(BOOL)animated {
    // Preload the picker with user settings.
    NSInteger row = [[[NSUserDefaults standardUserDefaults] objectForKey:@"row"] intValue];
    if ((row >= 0) && (row < [_pickerData count])) {
        [self.signPicker selectRow:row inComponent:0 animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [self._mainController viewDidLoad];
    // Dispose of any resources that can be recreated.
}

# pragma mark - picker methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    // Save selection to user defaults dict.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_pickerData[row] forKey:@"sign"];
    [userDefaults setObject:[NSNumber numberWithInt:(int)row] forKey:@"row"];
    [userDefaults synchronize];
    
    // Relaod main view controller
    [self.parentViewController.parentViewController viewDidLoad];

}
@end
