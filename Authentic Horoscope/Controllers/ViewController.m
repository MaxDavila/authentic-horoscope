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
#import <Reachability/Reachability.h>

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ViewController {
    NSArray *myViewControllers;
    UserHoroscope *userHoroscope;
    AppManager *app;
    Horoscope *horoscope;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userHoroscope = [UserHoroscope sharedInstance];
    app = [AppManager sharedManager];
    horoscope = [Horoscope sharedInstance];

    [self checkConnectivity];
}

# pragma mark - helper methods

- (void)checkConnectivity {
    [AppManager checkConnectivity:^(void) {
        app.isOnline = true;
        [self showOnlinePrediction];
    } failureBlock:^(void) {
        app.isOnline = false;
        [self showOfflinePrediction];
    }];
}
- (void)showOnlinePrediction {
    [self loadPrediction];
    [self registerObserversOnce];
}
- (void)showOfflinePrediction {
    userHoroscope.snippetHoroscope = [horoscope getOfflinePrediction];
    [self setupViewControllers];
}

- (void)loadPrediction {
    NSString *today = [AppManager getFormattedDate];
    [HoroscopeApi getPredictionsFor:today withSuccessBlock:^(NSDictionary *responseObject) {
        if (responseObject) {
            // Load singleton Horoscope instance from response object
            [horoscope loadData:responseObject];
            [self loadViewControllers];
        }
    }];
}

- (void)loadViewControllers {
    NSLog(@"hit from loadviewcontroller");
    [self storePrediction];
    [self setupViewControllers];
}

- (void)storePrediction {
    NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];
    if (sign) {
        [userHoroscope update:horoscope forSign:sign];
    }
}

- (void)setupViewControllers {
    // First remove previous views and child viewcontrollers
    [self.pageViewController willMoveToParentViewController:nil];
    [self.pageViewController.view removeFromSuperview];
    [self.pageViewController removeFromParentViewController];
    
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

- (void)registerObserversOnce {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadViewControllers)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
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
