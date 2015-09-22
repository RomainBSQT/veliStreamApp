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
	self.distantId = [dictionary nonNullObjectForKey:@"_id"];
	self.avatarUrl = [dictionary nonNullObjectForKey:@"avatar"];
	self.facebookId = [dictionary nonNullObjectForKey:@"facebook_id"];
	self.username = [dictionary nonNullObjectForKey:@"username"];
}

#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
	if (self == object) {
		return YES;
	}
	
	if (![object isKindOfClass:[self class]]) {
		return NO;
	}
	
	RBTFriend *profile = object;
	return [profile.distantId isEqualToString:self.distantId] &&
	[profile.facebookId isEqualToString:self.facebookId];
}

- (NSUInteger)hash
{
	return [self.distantId hash] ^ [self.facebookId hash];
}

@end