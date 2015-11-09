//
//  RBTLaunchScreenViewController.m
//  veli
//
//  Created by Romain Bousquet on 19/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTLaunchScreenViewController.h"
#import "RBTAppDelegate.h"

@interface RBTLaunchScreenViewController ()

@end

@implementation RBTLaunchScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	[(RBTAppDelegate *)[[UIApplication sharedApplication] delegate] showHome];
}

@end
