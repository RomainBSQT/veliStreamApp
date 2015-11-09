//
//  RBTJoinLeftInformations.m
//  veli
//
//  Created by Romain Bousquet on 06/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTJoinLeftInformations.h"
#import "RBTFriend.h"

@interface RBTJoinLeftInformations ()

@property (assign, readwrite, nonatomic) RBTEventType eventType;
@property (strong, readwrite, nonatomic) NSString *username;
@property (strong, readwrite, nonatomic) RBTFriend *currentFriend;
@property (strong, readwrite, nonatomic) UIColor *color;
@property (strong, readwrite, nonatomic) NSDate *dateCreated;

@end

@implementation RBTJoinLeftInformations

+ (instancetype)instanceWithEventType:(RBTEventType)eventType currentFriend:(RBTFriend *)currentFriend
{
	RBTJoinLeftInformations *instance = [[RBTJoinLeftInformations alloc] init];
	instance.eventType = eventType;
	instance.currentFriend = currentFriend;
	instance.username = currentFriend.username;
	instance.color = [RBTTheme nextColor];
	instance.dateCreated = [NSDate date];
	return instance;
}

+ (instancetype)instanceWithEventType:(RBTEventType)eventType username:(NSString *)username
{
	RBTJoinLeftInformations *instance = [[RBTJoinLeftInformations alloc] init];
	instance.eventType = eventType;
	instance.username = username;
	instance.color = [RBTTheme nextColor];
	instance.dateCreated = [NSDate date];
	return instance;
}

+ (NSArray *)arrayInstanceWithDict:(NSDictionary *)dictionary
{
	NSMutableArray *instanceArray = [NSMutableArray new];
	if (dictionary[@"joined"]) {
		[dictionary[@"joined"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			RBTJoinLeftInformations *instance = [RBTJoinLeftInformations instanceWithEventType:RBTEventTypeJoin username:obj];
			[instanceArray addObject:instance];
		}];
	}
	if (dictionary[@"left"]) {
		[dictionary[@"left"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			RBTJoinLeftInformations *instance = [RBTJoinLeftInformations instanceWithEventType:RBTEventTypeLeft username:obj];
			[instanceArray addObject:instance];
		}];
	}
	return instanceArray;
}

#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
	if (self == object) {
		return YES;
	}
	if (![object isKindOfClass:[self class]]) {
		return NO;
	}
	RBTJoinLeftInformations *info = object;
	if (info.currentFriend == nil && self.currentFriend == nil) {
		return [info.username isEqualToString:self.username];
	}
	return [info.currentFriend.distantId isEqualToString:self.currentFriend.distantId];
}

- (NSUInteger)hash
{
	return [self.username hash];
}

@end
