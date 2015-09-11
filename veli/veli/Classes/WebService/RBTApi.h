//
//  RBTApi.h
//  veli
//
//  Created by Romain Bousquet on 21/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTURLBuilder.h"
#import "RBTAFNetworkingClientManager.h"

typedef void (^RBTApiSuccess)(id responseObject);
typedef void (^RBTApiFailure)(NSError *error);

@interface RBTApi : NSObject

@property (nonatomic, strong) RBTURLBuilder *urlBuilder;

+ (RBTApi *)sharedApi;

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(RBTRequestSuccess)success failure:(RBTRequestFailure)failure;

@end
