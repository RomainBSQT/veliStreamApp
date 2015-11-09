//
//  RBTAFNetworkingContentProvider.m
//  veli
//
//  Created by Romain Bousquet on 23/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTAFNetworkingClientManager.h"
#import "RBTWSUrlConstants.h"

@interface RBTAFNetworkingClientManager ()

@end

@implementation RBTAFNetworkingClientManager

+ (instancetype)sharedClient
{
	static RBTAFNetworkingClientManager *sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[RBTAFNetworkingClientManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]
														sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	});
	return sharedClient;
}

#pragma mark - WS calls methods

- (void)getURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self GET:url parameters:parameters success:success failure:failure];
}

- (void)postURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self POST:url parameters:parameters success:success failure:failure];
}

- (void)deleteURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self DELETE:url parameters:parameters success:success failure:failure];
}

- (void)putURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure
{
	[self PUT:url parameters:parameters success:success failure:failure];
}

@end
