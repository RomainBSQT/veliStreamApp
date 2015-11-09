//
//  RBTUser.h
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RBTFriend;

@interface RBTUser : NSObject <RBTParsing, NSSecureCoding>

@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *distantId;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSString *username;

+ (RBTUser *)userWithDictionary:(NSDictionary *)dictionary;
- (void)setupWithDictionary:(NSDictionary *)dictionary;

@end

@interface RBTUser (Helpers)

+ (RBTUser *)currentUser;

@end