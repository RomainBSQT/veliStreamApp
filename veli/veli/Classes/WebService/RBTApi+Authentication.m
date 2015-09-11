//
//  RBTApi+Authentication.m
//  veli
//
//  Created by Romain Bousquet on 17/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTApi+Authentication.h"
#import "RBTLocalStorageManager.h"
#import "RBTUser.h"

@implementation RBTApi (Authentication)

- (void)registerWithParameters:(NSDictionary *)parameters success:(RBTApiSuccess)success failure:(RBTApiFailure)failure
{
	[self getPath:[self.urlBuilder urlWithUrlType:RBTURLTypeRegister] parameters:parameters success:^(NSURLSessionTask *task, id responseObject) {
		RBTUser *user = [RBTUser userWithDictionary:responseObject];
		[RBTLocalStorageManager save:user];
		if (success) {
			success(responseObject);
		}
	} failure:^(NSURLSessionTask *task, NSError *error) {
		if (failure) {
			failure(error);
		}
	}];
}

@end
