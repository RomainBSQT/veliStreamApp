//
//  RBTHomeAndStreamingViewController.h
//  veli
//
//  Created by Romain Bousquet on 29/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

typedef NS_ENUM(NSUInteger, RBTHomeAndStreamingState) {
	RBTHomeState,
	RBTStreamingState
};

@protocol RBTHomeAndStreamingSwitchDelegate <NSObject>

- (void)switchToState:(RBTHomeAndStreamingState)state;
- (void)showFriendList;

@end

@interface RBTHomeAndStreamingViewController : RBTViewController
@end
