//
//  RBTFriendManager.m
//  veli
//
//  Created by Romain Bousquet on 24/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendCacheService.h"
#import "RBTFriendsService.h"

typedef NS_ENUM(NSInteger, RBTFriendListState) {
	RBTFriendListStateNotLoaded,
	RBTFriendListStateLoaded
};

@interface RBTFriendCacheService ()

@property (nonatomic) RBTFriendListState cacheState;
@property (copy, nonatomic) NSArray *friendArray;

@end

@implementation RBTFriendCacheService

#pragma mark - Singleton

+ (RBTFriendCacheService *)sharedInstance
{
	static RBTFriendCacheService *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[RBTFriendCacheService alloc] init];
	});
	return sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_cacheState = RBTFriendListStateNotLoaded;
		_friendArray = [[NSMutableArray alloc] init];
	}
	return self;
}

#pragma mark - Public methods

- (RACSignal *)retrieveFriends
{
	switch (self.cacheState) {
		case RBTFriendListStateNotLoaded:
			return [self loadFriends];
		case RBTFriendListStateLoaded:
			return [self cacheContent];
	}
}

#pragma mark - Private methods

- (RACSignal *)cacheContent
{
	return [RACSignal return:self.friendArray];
}

- (RACSignal *)loadFriends
{
	return [[RBTFriendsService fetchFriends] map:^id(id a) {
		return nil;
	}];
}

@end
