//
//  ViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "LandingViewController.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ViewController {
    NSArray *myViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPrediction];
}

# pragma mark - helper methods
- (void)loadPrediction {
    [HoroscopeApi getPredictionsFor:@"02/18/15" withSuccessBlock:^(NSDictionary *responseObject) {
        if (responseObject)
            [self showPrediction:responseObject];
    }];
}

- (void)showPrediction:(NSDictionary *)responseObject {
    
    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];
    if (sign) {
        Horoscope *horoscope = [Horoscope initWithData:responseObject];
        self.todayHoroscope = [horoscope getSnippetForSign:sign];
        
        // Store the snippet prediction to be accessed later
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.todayHoroscope forKey:@"predictionSnippet"];
    }
    else {
        self.todayHoroscope = @"Go set your sign!";
    }
    
    [self setupViewControllers];
    
}

- (void)setupViewControllers {
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    myViewControllers = @[@"SignsViewController",@"LandingViewController",@"AVCamViewController"];
    
    NSArray *viewControllers = @[[self viewControllerAtIndex:1]];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

#pragma mark - Page View Controller Data Source methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [myViewControllers indexOfObject:[viewController restorationIdentifier]];
    
    if (index == 0)
        return nil;
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [myViewControllers indexOfObject:[viewController restorationIdentifier]];
    index++;
    
    if (index == [myViewControllers count])
        return nil;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSString *identifier = myViewControllers[index];
    NSString *predictionSnippet = [[NSUserDefaults standardUserDefaults] objectForKey:@"predictionSnippet"];

    if ([identifier  isEqualToString:@"LandingViewController"]) {
        LandingViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        viewcontroller.snippetText = predictionSnippet;
        return viewcontroller;
    }
    else {
        UIViewController *viewController = [self.storyboard
                                            instantiateViewControllerWithIdentifier:identifier];
        return viewController;
    }
}
@end
