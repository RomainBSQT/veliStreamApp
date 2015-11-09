//
//  RBTURLBuilder.m
//  veli
//
//  Created by Romain Bousquet on 06/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTURLBuilder.h"
#import "RBTWSUrlConstants.h"
#import "RBTUser.h"

NSString* NSStringForUrlType(RBTURLType urlType);

@implementation RBTURLBuilder

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
	static dispatch_once_t onceToken;
	static RBTURLBuilder *instance = nil;
	dispatch_once(&onceToken, ^{
		instance = [[RBTURLBuilder alloc] init];
	});
	return instance;
}

#pragma mark - URL

- (NSString *)urlWithUrlType:(RBTURLType)urlType
{
	NSURL *url = [[NSURL alloc] initWithString:kBaseUrl];
	url = [url URLByAppendingPathComponent:NSStringForUrlType(urlType)];
	return [url absoluteString];
}

+ (NSString *)SSEURLSubscribe
{
	NSString *url = [NSString stringWithFormat:@"%@%@", kSSEURL, kSSEURLSubscribingParams];
	return [NSString stringWithFormat:url, [RBTUser currentUser].distantId, [RBTUser currentUser].username];
}

@end

NSString* NSStringForUrlType(RBTURLType urlType) {
	switch (urlType) {
		case RBTURLTypeRegister: return kRegisterUrl;
		case RBTURLTypeUsers: return kUsersUrl;
		case RBTURLTYpeUser: return kUserUrl;
	}
	return nil;
}