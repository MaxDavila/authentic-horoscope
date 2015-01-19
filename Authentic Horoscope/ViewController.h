//
//  ViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 1/17/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "Horoscope.h"


@interface ViewController : UIViewController <NSXMLParserDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSString *todayHoroscope;
@property (strong, nonatomic) NSString *birthdate;

@property NSUInteger pageCount;

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;


@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableDictionary *dataStorage;

@property (nonatomic, strong) NSMutableDictionary *tempDataStorage;
@property (nonatomic, strong) NSMutableString *foundValue;
@property (nonatomic, strong) NSString *currentElement;
@end

