//
//  RBTUser.m
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTUser.h"
#import "RBTApi.h"
#import "RBTLocalStorageManager.h"

@implementation RBTUser

#pragma mark - Setup

+ (RBTUser *)userWithDictionary:(NSDictionary *)dictionary
{
	RBTUser *user = [[[self class] alloc] init];
	[user setupWithDictionary:dictionary];
	return user;
}

- (void)setupWithDictionary:(NSDictionary *)dictionary
{
	self.userToken = [dictionary nonNullObjectForKey:@"user_token"];
	self.distantId = [dictionary nonNullObjectForKey:@"_id"];
	self.avatarUrl = [dictionary nonNullObjectForKey:@"avatar"];
	self.facebookId = [dictionary nonNullObjectForKey:@"facebook_id"];
	self.username = [dictionary nonNullObjectForKey:@"username"];
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding
{
	return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.userToken forKey:@"userToken"];
	[aCoder encodeObject:self.distantId forKey:@"distantId"];
	[aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
	[aCoder encodeObject:self.facebookId forKey:@"facebookId"];
	[aCoder encodeObject:self.username forKey:@"username"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_userToken = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"userToken"];
		_distantId = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"distantId"];
		_avatarUrl = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"avatarUrl"];
		_facebookId = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"facebookId"];
		_username = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"username"];
	}
	return self;
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
	
	RBTUser *profile = object;
	return [profile.distantId isEqualToString:self.distantId] &&
		[profile.userToken isEqualToString:self.userToken];
}

- (NSUInteger)hash
{
	return [self.distantId hash] ^ [self.userToken hash];
}

@end

@implementation RBTUser (Helpers)

+ (RBTUser *)currentUser
{
	return [RBTLocalStorageManager currentUser];
}

@end