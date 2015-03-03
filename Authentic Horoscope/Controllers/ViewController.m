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
#import "AppManager.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ViewController {
    NSArray *myViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPrediction];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadViewControllers)
     
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
    
    // offline
//    UserHoroscope *userHoroscope = [UserHoroscope sharedInstance];
//    userHoroscope.snippetHoroscope = @"Always remember that you are unique. Just like everyone else.";
//    [self setupViewControllers];

}

# pragma mark - helper methods
- (void)reloadViewControllers {
    [self storePrediction];
    
    // Remove view and child viewcontrollers
    [self.pageViewController willMoveToParentViewController:nil];
    [self.pageViewController.view removeFromSuperview];
    [self.pageViewController removeFromParentViewController];
    
    [self setupViewControllers];
}

- (void)loadPrediction {
    NSString *today = [AppManager getFormattedDate];
    [HoroscopeApi getPredictionsFor:today withSuccessBlock:^(NSDictionary *responseObject) {
        if (responseObject) {
            // Load singleton Horoscope instance from response object
            [[Horoscope sharedInstance] loadData:responseObject];
            [self showPrediction];
        }
    }];
}

- (void)showPrediction {
    [self storePrediction];
    [self setupViewControllers];
}

- (void)storePrediction {
    // Load singleton Horoscope instance from response object
    Horoscope *horoscope = [Horoscope sharedInstance];
    
    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];
    if (sign) {
        [[UserHoroscope sharedInstance] update:horoscope forSign:sign];
    }
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
