//
//  RBTLocalStorageManager.h
//  veli
//
//  Created by Romain Bousquet on 27/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBTUser;

@interface RBTLocalStorageManager : NSObject

+ (RBTUser *)currentUser;
+ (void)save:(RBTUser *)user;
+ (BOOL)isUserExisting;

@end