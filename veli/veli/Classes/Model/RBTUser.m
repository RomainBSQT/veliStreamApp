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
	self.acess_token = [dictionary nonNullObjectForKey:@"api_key"];
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

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding
{
	return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.acess_token forKey:@"acess_token"];
	[aCoder encodeObject:self.distantId forKey:@"distantId"];
	[aCoder encodeObject:self.live_audience forKey:@"live_audience"];
	[aCoder encodeObject:self.live_key forKey:@"live_key"];
	[aCoder encodeObject:self.username forKey:@"username"];
	[aCoder encodeObject:self.facebook_social_id forKey:@"facebook_social_id"];
	[aCoder encodeObject:self.facebook_oauth_token forKey:@"facebook_oauth_token"];
	[aCoder encodeObject:self.picture_url forKey:@"picture_url"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_acess_token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"acess_token"];
		_distantId = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"distantId"];
		_live_audience = [aDecoder decodeObjectOfClass:[NSNumber class] forKey:@"live_audience"];
		_live_key = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"live_key"];
		_username = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"username"];
		_facebook_social_id = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"facebook_social_id"];
		_facebook_oauth_token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"facebook_oauth_token"];
		_picture_url = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"picture_url"];
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
		[profile.acess_token isEqualToString:self.acess_token];
}

- (NSUInteger)hash
{
	return [self.distantId hash] ^ [self.acess_token hash];
}

@end

@implementation RBTUser (Helpers)

+ (RBTUser *)currentUser
{
	return [RBTLocalStorageManager currentUser];
}

@end