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

@interface RBTUser : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *acess_token;
@property (nonatomic, copy) NSString *distantId;
@property (nonatomic, strong) NSNumber *live_audience;
@property (nonatomic, copy) NSString *live_key;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *facebook_social_id;
@property (nonatomic, copy) NSString *facebook_oauth_token;
@property (nonatomic, copy) NSString *picture_url;

+ (RBTUser *)userWithDictionary:(NSDictionary *)dictionary;
- (void)setupWithDictionary:(NSDictionary *)dictionary;

@end

@interface RBTUser (Helpers)

+ (RBTUser *)currentUser;

@end