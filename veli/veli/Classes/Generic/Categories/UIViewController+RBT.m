//
//  UIViewController+IBP.m
//  veli
//
//  Created by Romain Bousquet on 11/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIViewController+RBT.h"
#import "UIAlertView+RBTAlertView.h"

@implementation UIViewController (RBT)

- (void)handleAPIError:(NSError *)error
{
	NSString *errorMessage = NSLocalizedString(@"A little problem occured, sorry about that !", nil);
	[UIAlertView showAlertViewWithWarningTitleAndMessage:errorMessage];
}

- (void)addChildViewController:(UIViewController *)childController withEdgeInsets:(UIEdgeInsets)edgeInsets inView:(UIView*)containerView
{
	NSAssert(nil != containerView, @"containerView must not be nil");
	
	[self addChildViewController:childController];
	[childController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	[containerView addSubview:childController.view];
	[childController didMoveToParentViewController:self];
	
	NSMutableDictionary *viewsDict = [NSMutableDictionary new];
	viewsDict[@"childView"] = childController.view;
	
	NSMutableDictionary *metricsDict = [NSMutableDictionary new];
	metricsDict[@"topSpace"]    = @(edgeInsets.top);
	metricsDict[@"bottomSpace"] = @(edgeInsets.bottom);
	metricsDict[@"leftSpace"]   = @(edgeInsets.left);
	metricsDict[@"rightSpace"]  = @(edgeInsets.right);
	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topSpace)-[childView]-(bottomSpace)-|"
																		  options:0
																		  metrics:metricsDict
																			views:viewsDict]];
	[containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leftSpace)-[childView]-(rightSpace)-|"
																		  options:0
																		  metrics:metricsDict
																			views:viewsDict]];
}


@end
