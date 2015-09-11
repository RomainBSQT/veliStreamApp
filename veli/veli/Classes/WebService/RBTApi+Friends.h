//
//  RBTApi+Friends.h
//  veli
//
//  Created by Romain Bousquet on 06/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTApi.h"

@interface RBTApi (Friends)

- (void)getFriendsWithSuccess:(RBTApiSuccess)success failure:(RBTApiFailure)failure;

@end
