//
//  RBTFriendManager.m
//  veli
//
//  Created by Romain Bousquet on 24/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTFriendManager.h"
#import "RBTApi+Friends.h"

typedef NS_ENUM(NSInteger, RBTFriendListState) {
	RBTFriendListStateNotLoaded,
	RBTFriendListStateLoaded
};

@interface RBTFriendManager ()

@property (nonatomic) RBTFriendListState cacheState;
@property (copy, nonatomic) NSArray *friendArray;

@end

@implementation RBTFriendManager

#pragma mark - Singleton

+ (RBTFriendManager *)sharedInstance
{
	static RBTFriendManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[RBTFriendManager alloc] init];
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

- (RACSignal *)friends
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
	@weakify(self)
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[[RBTApi sharedApi] getFriendsWithSuccess:^(NSArray *friendArray) {
			@strongify(self)
			self.friendArray = friendArray;
			[subscriber sendNext:friendArray];
			self.cacheState = RBTFriendListStateLoaded;
			[subscriber sendCompleted];
		} failure:^(NSError *error) {
			[subscriber sendError:error];
		}];
		return nil;
	}];
}

@end
