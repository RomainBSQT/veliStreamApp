//
//  RBTFriendsInviteViewController.h
//  veli
//
//  Created by Romain Bousquet on 25/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

@protocol RBTFriendsInviteDelegate <NSObject>

- (void)didExitFriendsInvite:(id)sender;
- (void)didValidateFriendsInvite:(NSArray *)friendsArray;

@end

@interface RBTFriendsInviteViewController : RBTViewController

@property (weak, nonatomic) id<RBTFriendsInviteDelegate> delegate;

@end
