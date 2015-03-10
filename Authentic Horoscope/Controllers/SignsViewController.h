//
//  LandingViewController.h
//  Authentic Horoscope
//
//  Created by Max Davila on 2/18/15.
//  Copyright (c) 2015 Max Davila. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignsViewControllerDelegate;


@interface SignsViewController : UIViewController

@property (nonatomic, weak) id<SignsViewControllerDelegate> delegate;

@end


@protocol SignsViewControllerDelegate <NSObject>

- (void)goToPageAtIndex:(NSUInteger)index;

@end
