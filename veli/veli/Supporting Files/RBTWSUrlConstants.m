//
//  RBTWSUrlConstants.m
//  veli
//
//  Created by Romain Bousquet on 21/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTWSUrlConstants.h"

NSString *const kBaseUrl = @"http://52.28.29.59:8080/v1";

//-- Authentication
NSString *const kRegisterUrl = @"/auth/register";

NSString *const kUsersUrl = @"/users";
NSString *const kUserUrl = @"/users/%@";

//-- SSE
NSString *const kSSEURL = @"http://104.131.82.26:9999";

NSString *const kSSEURLSubscribingParams = @"/%@?username=%@";