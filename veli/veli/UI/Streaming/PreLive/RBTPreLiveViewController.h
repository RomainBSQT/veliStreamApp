//
//  RBTPreLiveViewController.h
//  veli
//
//  Created by Romain Bousquet on 04/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewController.h"

@protocol RBTHomeAndStreamingSwitchDelegate;

@interface RBTPreLiveViewController : RBTViewController

@property (weak, nonatomic) id <RBTHomeAndStreamingSwitchDelegate> delegate;

@end
