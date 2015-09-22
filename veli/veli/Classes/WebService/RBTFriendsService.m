
//
//  RBTFriendsService.m
//  veli
//
//  Created by Romain Bousquet on 22/09/2015.
//  Copyright © 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendsService.h"
#import "RBTApi.h"
#import "RBTUser.h"

@implementation RBTFriendsService

+ (RACSignal *)fetchFriends
{
	NSAssert([RBTUser currentUser].userToken != nil, @"Should have logged in before");
	
	RBTApi *sharedApi = [RBTApi sharedApi];
	
	NSDictionary *params = @{@"user_token": [RBTUser currentUser].userToken};
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[sharedApi getPath:[sharedApi.urlBuilder urlWithUrlType:RBTURLTypeUsers] parameters:params success:^(NSURLSessionTask *task, id responseObject) {
			[subscriber sendNext:responseObject];
			[subscriber sendCompleted];
		} failure:^(NSURLSessionTask *task, NSError *error) {
			[subscriber sendError:error];
		}];
		return nil;
	}];
}

@end
