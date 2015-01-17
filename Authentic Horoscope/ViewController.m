//
//  ViewController.m
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCount = 3;
    self.horoscope = @"YOOOOO";
    NSURL *url = [NSURL URLWithString:@"http://www.findyourfate.com/rss/horoscope-astrology-feed.asp?mode=view&todate=1/16/2015"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    self.xmlParser = [[NSXMLParser alloc] initWithData:data];
    self.xmlParser.delegate = self;
    
    // Initialize the mutable string that we'll use during parsing.
    self.foundValue = [[NSMutableString alloc] init];
    
    // Start parsing.
    [self.xmlParser parse];
    
    [self.resultArray removeObjectAtIndex:0];
    [self.resultArray removeObjectAtIndex:(NSUInteger)[self.resultArray count] -1];
    NSLog(@"string: %@", self.resultArray);
    

    

    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - xml parser

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the result array.
    self.resultArray = [[NSMutableArray alloc] init];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Result array %@", self.resultArray);
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    // If the current element name is equal to "item" then initialize the temporary dictionary.
    if ([elementName isEqualToString:@"item"]) {
        self.tempDataStorage = [[NSMutableDictionary alloc] init];
    }
    
    // Keep the current element.
    self.currentElement = elementName;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // Add tempDatastorage to resultArray when the desired tag closing bracked has been reached
    if ([elementName isEqualToString:@"item"]) {
        [self.resultArray addObject:[[NSDictionary alloc] initWithDictionary:self.tempDataStorage]];  }
    // Add title to tempDataStorage dict.
    else if ([elementName isEqualToString:@"title"]){
        [self.tempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"title"];
    }
    // Add description to tempDataStorage dict.
    else if ([elementName isEqualToString:@"description"]){
        [self.tempDataStorage setObject:[NSString stringWithString:self.foundValue] forKey:@"description"];
    }
    
    // Clear the mutable string.
    [self.foundValue setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // Stream the current string if we found the desired element.
    if ([self.currentElement isEqualToString:@"title"] ||
        [self.currentElement isEqualToString:@"description"]) {
        
        if (![string isEqualToString:@"\n"]) {
            [self.foundValue appendString:string];
        }
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PageContentViewController *currentViewController = (PageContentViewController *)viewController;
    NSUInteger index = currentViewController.pageIndex;
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PageContentViewController *currentViewController = (PageContentViewController *)viewController;
    NSUInteger index = currentViewController.pageIndex;
    
    index++;
    if (index == self.pageCount) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
//    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
//        return nil;
//    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.horoscopeText = self.horoscope;
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
@end
