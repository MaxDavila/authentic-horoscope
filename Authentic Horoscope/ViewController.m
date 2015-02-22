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
#import "UserHoroscope.h"

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
    NSString *today = [self getFormattedDate];
    [HoroscopeApi getPredictionsFor:today withSuccessBlock:^(NSDictionary *responseObject) {
        if (responseObject)
            [self showPrediction:responseObject];
    }];
}
- (NSString *)getFormattedDate {
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"M/dd/yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];

    return localDateString;
}

- (void)showPrediction:(NSDictionary *)responseObject {
    // Load singleton Horoscope instance from response object
    Horoscope *horoscope = [Horoscope sharedInstance];
    [horoscope loadData:responseObject];

    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];
    if (sign) {
        UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
        userHoroscope.snippetHoroscope = [horoscope getSnippetForSign:sign];
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
    UIViewController *viewController = [self.storyboard
                                            instantiateViewControllerWithIdentifier:identifier];
    return viewController;

}
@end
