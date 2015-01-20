//
//  ViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMLParser.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ViewController {
    NSArray *myViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup url
    NSString *urlString = @"http://www.findyourfate.com/rss/horoscope-astrology-feed.asp?mode=view&todate=1/16/2015";
    
    // Make async request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;

    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary *parsedResponse = [XMLParser getParsedResponse:responseObject];
            
            NSString *sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"sign"];
            if (sign) {
                Horoscope *horoscope = [Horoscope initWithData:parsedResponse];
                self.todayHoroscope = [horoscope getSnippetForSign:sign];
            }
            else {
                self.todayHoroscope = @"Go set your sign!";
            }
            
            [self setupViewControllers];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

# pragma mark - helper methods

- (void) setupViewControllers {
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    myViewControllers = @[@"SettingsViewController",@"LandingViewController",@"CameraViewController"];
    
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

    if ([identifier  isEqualToString:@"LandingViewController"]) {
        LandingViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        viewcontroller.snippetText = self.todayHoroscope;
        return viewcontroller;
    }
    else {
        UIViewController *viewController = [self.storyboard
                                            instantiateViewControllerWithIdentifier:identifier];
        return viewController;
    }
}
@end
