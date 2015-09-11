//
//  RBTJoinLeftViewController.h
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

@class RBTJoinLeftInformations;

@interface RBTJoinLeftViewController : RBTViewController

- (void)addFriendForAnimation:(RBTJoinLeftInformations *)newInformation;
- (void)reset;

@end
