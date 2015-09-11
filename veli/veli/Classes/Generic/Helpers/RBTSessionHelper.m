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
#import "RBTApi+Authentication.h"
#import "RBTUser.h"

typedef void (^RBTAuthenticationSuccess)(FBSDKAccessToken *token);
typedef void (^RBTAuthenticationFailure)(NSError *error, enum RBTAuthenticationStatus status);

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

- (void)login:(RBTApiSuccess)success failure:(RBTApiFailure)failure
{
	[self facebookAuthenticationWithSuccess:^(FBSDKAccessToken *token) {
		NSDictionary *params = @{@"social_id": token.userID, @"oauth_token": token.tokenString};
		[[RBTApi sharedApi] registerWithParameters:params success:^(id ret) {
			if (success) {
				success(ret);
			}
		} failure:^(NSError *error) {
			if (failure) {
				failure(error);
			}
		}];
	} failure:^(NSError *error, enum RBTAuthenticationStatus status) {
		if (failure) {
			failure(error);
		}
	}];
	

}

#pragma mark - Facebook authentication

- (BOOL)isFacebookSessionActive
{
	return [FBSDKAccessToken currentAccessToken] != nil;
}

- (void)facebookAuthenticationWithSuccess:(RBTAuthenticationSuccess)success failure:(RBTAuthenticationFailure)failure
{
	FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
	[login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
		if (error) {
			if (failure) {
				failure(error, RBTAuthenticationStatusFailed);
			}
		} else if (result.isCancelled) {
			if (failure) {
				failure(nil, RBTAuthenticationStatusCanceled);
			}
		} else {
			if (success) {
				success(result.token);
			}
		}
	}];
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