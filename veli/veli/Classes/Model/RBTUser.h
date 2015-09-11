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

@property (nonatomic, strong) NSString * acess_token;
@property (nonatomic, strong) NSString * distantId;
@property (nonatomic, strong) NSNumber * live_audience;
@property (nonatomic, strong) NSString * live_key;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * facebook_social_id;
@property (nonatomic, strong) NSString * facebook_oauth_token;
@property (nonatomic, strong) NSString * picture_url;

+ (RBTUser *)userWithDictionary:(NSDictionary *)dictionary;
- (void)setupWithDictionary:(NSDictionary *)dictionary;

@end

@interface RBTUser (Helpers)

+ (RBTUser *)currentUser;

@end