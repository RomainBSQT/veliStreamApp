//
//  RBTAFNetworkingContentProvider.h
//  veli
//
//  Created by Romain Bousquet on 23/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^RBTRequestSuccess)(NSURLSessionTask *task, id responseObject);
typedef void (^RBTRequestFailure)(NSURLSessionTask *task, NSError *error);

@interface RBTAFNetworkingClientManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)getURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)postURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)deleteURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)putURL:(NSString *)url parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;

@end
