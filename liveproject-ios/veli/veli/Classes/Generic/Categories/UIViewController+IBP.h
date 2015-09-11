//
//  UIViewController+IBP.h
//  veli
//
//  Created by Romain Bousquet on 11/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (IBP)

- (void)handleAPIError:(NSError *)error;
- (void)addChildViewController:(UIViewController *)childController withEdgeInsets:(UIEdgeInsets)edgeInsets inView:(UIView*)containerView;

@end
