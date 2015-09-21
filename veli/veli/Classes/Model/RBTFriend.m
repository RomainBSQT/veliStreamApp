//
//  RBTFriend.m
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriend.h"
#import "RBTFriendCacheService.h"
#import "RBTApi.h"

@implementation RBTFriend

#pragma mark - Setup

+ (instancetype)friendWithDictionary:(NSDictionary *)dictionary
{
	RBTFriend *newFriend = [[RBTFriend alloc] init];
	[newFriend setupWithDictionary:dictionary];
	return newFriend;
}

- (void)setupWithDictionary:(NSDictionary *)dictionary
{
	self.distantId = [dictionary nonNullObjectForKey:@"id"];
	self.live_audience = [dictionary nonNullObjectForKey:@"live_audience"];
	self.picture_url = [[[dictionary nonNullObjectForKey:@"picture"] nonNullObjectForKey:@"data"] nonNullObjectForKey:@"url"];
	self.facebook_social_id = [dictionary nonNullObjectForKey:@"social_id"];
	
	NSString *firstName = @"";
	NSString *lastName = @"";
	if ([dictionary nonNullObjectForKey:@"first_name"]) {
		firstName = [dictionary nonNullObjectForKey:@"first_name"];
	}
	if ([dictionary nonNullObjectForKey:@"last_name"]) {
		lastName = [dictionary nonNullObjectForKey:@"last_name"];
	}
	self.username = [NSString stringWithFormat:@"%@%@", firstName, lastName];
}

@end

@implementation RBTFriend (Helpers)

+ (RACSignal *)allFriends
{
	return [[RBTFriendCacheService sharedInstance] friends];
}

@end