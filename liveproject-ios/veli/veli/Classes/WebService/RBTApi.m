//
//  RBTApi.m
//  veli
//
//  Created by Romain Bousquet on 21/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "RBTApi.h"
#import "RBTAFNetworkingClientManager.h"

@implementation RBTApi

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (RBTApi *)sharedApi
{
	static RBTApi *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [RBTApi new];
	});
	return sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_urlBuilder = [RBTURLBuilder new];
	}
	return self;
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self callPath:path parameters:parameters httpMethod:@"POST" downloadHelperSuccess:success downloadHelperFailure:failure];
}

- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self callPath:path parameters:parameters httpMethod:@"PUT" downloadHelperSuccess:success downloadHelperFailure:failure];
}

- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self callPath:path parameters:parameters httpMethod:@"DELETE" downloadHelperSuccess:success downloadHelperFailure:failure];
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self callPath:path parameters:parameters httpMethod:@"GET" downloadHelperSuccess:success downloadHelperFailure:failure];
}

- (void)callPath:(NSString *)path
	  parameters:(NSDictionary *)parameters
	  httpMethod:(NSString *)httpMethod
	downloadHelperSuccess:(RBTRequestSuccess)success
	downloadHelperFailure:(RBTRequestFailure)failure
{
	
	if ([httpMethod isEqualToString:@"GET"]) {
		[[RBTAFNetworkingClientManager sharedClient] getURL:path parameters:parameters success:success failure:failure];
	} else if ([httpMethod isEqualToString:@"POST"]) {
		[[RBTAFNetworkingClientManager sharedClient] postURL:path parameters:parameters success:success failure:failure];
	} else if ([httpMethod isEqualToString:@"DELETE"]) {
		[[RBTAFNetworkingClientManager sharedClient] deleteURL:path parameters:parameters success:success failure:failure];
	} else if ([httpMethod isEqualToString:@"PUT"]) {
		[[RBTAFNetworkingClientManager sharedClient] putURL:path parameters:parameters success:success failure:failure];
	} else {
		NSAssert(@"unsupported HTTP method: %@", httpMethod);
	}
}

@end