//
//  RBTStreamingViewController.h
//  veli
//
//  Created by Romain Bousquet on 25/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

@protocol RBTHomeAndStreamingSwitchDelegate;

@interface RBTStreamingViewController : RBTViewController

@property (strong, nonatomic) NSArray *invitedFriends;
@property (weak, nonatomic) id <RBTHomeAndStreamingSwitchDelegate> delegate;

@end
