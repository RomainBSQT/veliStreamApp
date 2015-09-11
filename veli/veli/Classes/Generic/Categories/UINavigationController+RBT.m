//
//  UINavigationController+RBT.m
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UINavigationController+RBT.h"
#import "RBTNavigationBar.h"
#import "UIImage+RBT.h"

@implementation UINavigationController (RBT)

+ (UINavigationController *)RBTNavigationControllerWithRootViewController:(UIViewController *)viewController
{
	UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[RBTNavigationBar class] toolbarClass:nil];
	[navController setViewControllers:@[viewController] animated:NO];
	
	navController.edgesForExtendedLayout = UIRectEdgeNone;
	navController.navigationBar.translucent = NO;
	navController.navigationBar.tintColor = [UIColor whiteColor];
	[navController.navigationBar setBackgroundImage:[UIImage RBTNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
	navController.navigationBar.shadowImage = [UIImage new];
	return navController;
}

- (void)statusBarAnimateIn
{
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)statusBarAnimateOut
{	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)popToViewController:(Class)aClass
{
	for (UIViewController *aViewController in [self viewControllers]) {
		if ([aViewController isKindOfClass:aClass]) {
			[self popToViewController:aViewController animated:NO];
		}
	}
}

@end
