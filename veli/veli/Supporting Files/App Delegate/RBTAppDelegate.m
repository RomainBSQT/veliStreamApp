//
//  AppDelegate.m
//  veli
//
//  Created by Romain Bousquet on 19/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTAppDelegate.h"

//-- Helpers
#import "RBTSessionHelper.h"
#import "UINavigationController+RBT.h"

//-- ViewControllers
#import "RBTLaunchScreenViewController.h"
#import "RBTLoginViewController.h"
#import "RBTFriendListViewController.h"

@interface RBTAppDelegate ()

@end

@implementation RBTAppDelegate

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self showLaunchScreen];
	[self.window makeKeyAndVisible];
	return [[RBTSessionHelper sharedInstance] facebookApplication:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[[RBTSessionHelper sharedInstance] facebookActivateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	return [[RBTSessionHelper sharedInstance] facebookApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

#pragma mark - Launching methods

- (void)showLaunchScreen
{
	self.window.rootViewController = [[RBTLaunchScreenViewController alloc] initWithNibName:nil bundle:nil];
}

- (void)showHome
{
	if ([RBTSessionHelper isLogged]) {
		UIViewController *controller = [[RBTFriendListViewController alloc] init];
		UINavigationController *navigationController = [UINavigationController RBTNavigationControllerWithRootViewController:controller];
		self.window.rootViewController = navigationController;
	} else {
		self.window.rootViewController = [RBTLoginViewController new];
	}
}

@end
