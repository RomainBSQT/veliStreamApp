//
//  RBTFriend.h
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RBTFriend : NSObject <RBTParsing>

@property (nonatomic, strong) NSString * distantId;
@property (nonatomic, strong) NSNumber * live_audience;
@property (nonatomic, strong) NSNumber * live_status;
@property (nonatomic, strong) NSString * live_key;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * facebook_social_id;
@property (nonatomic, strong) NSString * picture_url;

+ (instancetype)friendWithDictionary:(NSDictionary *)dictionary;

@end

@interface RBTFriend (Helpers)

+ (RACSignal *)allFriends;

@end