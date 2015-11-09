//
//  RBTSessionHelper.m
//  veli
//
//  Created by Romain Bousquet on 25/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "RBTSessionHelper.h"
#import "RBTUser.h"

@implementation RBTSessionHelper

#pragma mark - Singleton

+ (RBTSessionHelper *)sharedInstance
{
	static RBTSessionHelper *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [RBTSessionHelper new];
	});
	return sharedInstance;
}

+ (BOOL)isLogged
{
	return [RBTUser currentUser] != nil;
}

#pragma mark - Facebook authentication

- (BOOL)isFacebookSessionActive
{
	return [FBSDKAccessToken currentAccessToken] != nil;
}

#pragma mark - App delegate calls

- (void)facebookActivateApp
{
	[FBSDKAppEvents activateApp];
}

- (BOOL)facebookApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)facebookApplication:(UIApplication *)application openURL:(NSURL *)url
		  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	return [[FBSDKApplicationDelegate sharedInstance] application:application
														  openURL:url
												sourceApplication:sourceApplication
													   annotation:annotation];
}

@end