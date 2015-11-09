//
//  RBTPlayerViewController.h
//  veli
//
//  Created by Romain Bousquet on 11/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

@class RBTFriend;

@interface RBTPlayerViewController : RBTViewController

@property (nonatomic, weak) RBTFriend *streamingFriend;

@end
