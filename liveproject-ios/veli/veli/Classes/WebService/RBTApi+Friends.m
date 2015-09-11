//
//  RBTApi+Friends.m
//  veli
//
//  Created by Romain Bousquet on 06/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTApi+Friends.h"
#import "RBTFriend.h"
#import "RBTUser.h"

@implementation RBTApi (Friends)

- (void)getFriendsWithSuccess:(RBTApiSuccess)success failure:(RBTApiFailure)failure
{
	NSDictionary *params = @{@"t": [RBTUser currentUser].acess_token};
	[self getPath:[self.urlBuilder urlWithUrlType:RBTURLTypeUsers] parameters:params success:^(NSURLSessionTask *task, id responseObject) {
		__block NSMutableArray *friendArray = [[NSMutableArray alloc] init];
		[responseObject enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
			RBTFriend *currentFriend = [RBTFriend friendWithDictionary:dict];
			[friendArray addObject:currentFriend];
		}];
		if (success) {
			success(friendArray);
		}
	} failure:^(NSURLSessionTask *task, NSError *error) {
		if (failure) {
			failure(error);
		}
	}];
}

@end
