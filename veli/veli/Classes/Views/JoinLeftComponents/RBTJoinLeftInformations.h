//
//  RBTJoinLeftInformations.h
//  veli
//
//  Created by Romain Bousquet on 06/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBTViewersViewController.h"

@class RBTFriend;

typedef NS_ENUM(NSUInteger, RBTEventType) {
	RBTEventTypeJoin,
	RBTEventTypeLeft
};

@interface RBTJoinLeftInformations : NSObject

@property (assign, readonly, nonatomic) RBTEventType eventType;
@property (strong, readonly, nonatomic) NSString *username;
@property (strong, readonly, nonatomic) RBTFriend *currentFriend;
@property (strong, readonly, nonatomic) UIColor *color;
@property (strong, readonly, nonatomic) NSDate *dateCreated;

+ (instancetype)instanceWithEventType:(RBTEventType)eventType currentFriend:(RBTFriend *)currentFriend;
+ (instancetype)instanceWithEventType:(RBTEventType)eventType username:(NSString *)username;
+ (NSArray *)arrayInstanceWithDict:(NSDictionary *)dictionary;

@end
