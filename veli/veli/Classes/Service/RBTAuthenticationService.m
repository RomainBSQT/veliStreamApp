//
//  RBTAuthentificationService.m
//  veli
//
//  Created by Romain Bousquet on 17/09/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "RBTAuthenticationService.h"
#import "RBTLocalStorageManager.h"
#import "RBTApi.h"

@implementation RBTAuthenticationService

#pragma mark - Aggregate

+ (RACSignal *)authenticateWithUsername:(NSString *)username
{
	return [[[self class] facebookAuthentication] flattenMap:^RACStream *(FBSDKAccessToken *token) {
		return [[self class] authenticateWithFacebookToken:token username:username];
	}];
}

#pragma mark - Unitary service calls

+ (RACSignal *)facebookAuthentication
{
	FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
	
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
			if (error) {
				[subscriber sendError:error];
			} else if (result.isCancelled) {
				[subscriber sendCompleted];
			} else {
				[subscriber sendNext:result.token];
				[subscriber sendCompleted];
			}
		}];
		return nil;
	}];
}

+ (RACSignal *)authenticateWithFacebookToken:(FBSDKAccessToken *)facebookToken username:(NSString *)username
{
	RBTApi *sharedApi = [RBTApi sharedApi];
	NSDictionary *params = @{@"facebook_id": facebookToken.userID,
							 @"facebook_token": facebookToken.tokenString,
							 @"username": username};
	
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[sharedApi getPath:[sharedApi.urlBuilder urlWithUrlType:RBTURLTypeRegister] parameters:params success:^(NSURLSessionTask *task, id responseObject) {
			[subscriber sendNext:responseObject];
			[subscriber sendCompleted];
		} failure:^(NSURLSessionTask *task, NSError *error) {
			[subscriber sendError:error];
		}];
		return nil;
	}];
}

	 
@end
