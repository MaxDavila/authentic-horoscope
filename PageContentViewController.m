//
//  PageContentViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "PageContentViewController.h"
@import AVFoundation;

@interface PageContentViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation PageContentViewController  {
    NSArray *_pickerData;
    
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureDeviceInput *_videoInput;
    AVCaptureVideoPreviewLayer *_previewLayer;
    BOOL _running;
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
    
    self.previewView.hidden = YES;
    [self setupCaptureSession];
    _previewLayer.frame = _previewView.bounds;
    [_previewView.layer addSublayer:_previewLayer];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(self.presentCamera ? @"yes" : @"no");
    if (self.presentCamera) {
        [self startRunning];

        self.previewView.hidden = NO;

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Preload the picker with user settings.
    NSInteger row = [[[NSUserDefaults standardUserDefaults] objectForKey:@"row"] intValue];
    if ((row >= 0) && (row < [_pickerData count])) {
        [self.signPicker selectRow:row inComponent:0 animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopRunning];
}

- (void)applicationWillEnterForeground:(NSNotification*)note {
    [self startRunning];
}
- (void)applicationDidEnterBackground:(NSNotification*)note {
    [self stopRunning];
}

# pragma mark - Camera methods
- (void)setupCaptureSession {
    if (_captureSession) return;

    _videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (!_videoDevice) {
        NSLog(@"No video camera on this device!"); return;
    }

    _captureSession = [[AVCaptureSession alloc] init];
    _videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_videoDevice error:nil];
    
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (void)startRunning {
    if (_running) return;
    
    [_captureSession startRunning];
    _running = YES;
}

- (void)stopRunning {
    if (!_running) return;
    
    [_captureSession stopRunning];
    _running = NO;
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
