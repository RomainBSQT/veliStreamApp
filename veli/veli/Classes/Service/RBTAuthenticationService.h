//
//  RBTAuthentificationService.h
//  veli
//
//  Created by Romain Bousquet on 17/09/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTAuthenticationService : NSObject

+ (RACSignal *)authenticateWithUsername:(NSString *)username;

@end
