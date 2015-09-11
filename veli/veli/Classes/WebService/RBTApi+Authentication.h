//
//  RBTApi+Authentication.h
//  veli
//
//  Created by Romain Bousquet on 17/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTApi.h"

@interface RBTApi (Authentication)

- (void)registerWithParameters:(NSDictionary *)parameters success:(RBTApiSuccess)success failure:(RBTApiFailure)failure;

@end
