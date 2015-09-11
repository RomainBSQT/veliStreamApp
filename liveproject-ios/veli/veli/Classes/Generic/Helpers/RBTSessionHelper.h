//
//  RBTSessionHelper.h
//  veli
//
//  Created by Romain Bousquet on 25/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTApi.h"

NS_ENUM(NSInteger, RBTAuthenticationStatus) {
	RBTAuthenticationStatusFailed    = -1,
	RBTAuthenticationStatusCanceled  = 0,
	RBTAuthenticationStatusConnected = 1
};

@interface RBTSessionHelper : NSObject

+ (RBTSessionHelper *)sharedInstance;

+ (BOOL)isLogged;
- (void)login:(RBTApiSuccess)success failure:(RBTApiFailure)failure;

//-- AppDelegate relays
- (void)facebookActivateApp;
- (BOOL)facebookApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)facebookApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end