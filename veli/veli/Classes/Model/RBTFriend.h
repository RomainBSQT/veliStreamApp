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

@property (nonatomic, copy) NSString *distantId;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) BOOL isLive;

+ (instancetype)friendWithDictionary:(NSDictionary *)dictionary;

@end