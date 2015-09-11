//
//  RBTHomeAndStreamingViewController.m
//  veli
//
//  Created by Romain Bousquet on 29/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTHomeAndStreamingViewController.h"
#import "UINavigationController+RBT.h"
#import "RBTStreamingViewController.h"
#import "RBTFriendsInviteViewController.h"
#import "RBTPreLiveViewController.h"

@interface RBTHomeAndStreamingViewController () <RBTHomeAndStreamingSwitchDelegate, RBTFriendsInviteDelegate>

@property (strong, nonatomic) RBTStreamingViewController *streamingViewController;
@property (strong, nonatomic) RBTPreLiveViewController *homeViewController;
@property (weak, nonatomic) RBTFriendsInviteViewController *friendListController;

@end

@implementation RBTHomeAndStreamingViewController

#pragma mark - Controller life cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.navigationController statusBarAnimateOut];
	[self configureSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.navigationController statusBarAnimateOut];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)configureSubviews
{
	self.streamingViewController = [[RBTStreamingViewController alloc] init];
	self.streamingViewController.delegate = self;
	self.homeViewController = [[RBTPreLiveViewController alloc] init];
	self.homeViewController.delegate = self;
	[self changeChidWithState:RBTHomeState];
}

#pragma mark - RBTFriendsInviteDelegate

- (void)didExitFriendsInvite:(id)sender
{
	[self dismissFriendsInviteViewController];
}

- (void)didValidateFriendsInvite:(NSArray *)friendsArray
{
	self.streamingViewController.invitedFriends = friendsArray;
	[self changeChidWithState:RBTStreamingState];
	[self dismissFriendsInviteViewController];
}

- (void)dismissFriendsInviteViewController
{
	if (self.friendListController) {
		[self.friendListController.navigationController dismissViewControllerAnimated:YES completion:nil];
	}
}

#pragma mark - RBTHomeAndStreamingSwitchDelegate

- (void)switchToState:(RBTHomeAndStreamingState)state
{
	[self changeChidWithState:state];
}

- (void)showFriendList
{
	RBTFriendsInviteViewController *viewController = [RBTFriendsInviteViewController new];
	self.friendListController = viewController;
	viewController.delegate = self;
	UINavigationController *modalNC = [UINavigationController RBTNavigationControllerWithRootViewController:viewController];
	[self.navigationController presentViewController:modalNC animated:YES completion:nil];
}

#pragma mark - Controller flow

- (void)changeChidWithState:(RBTHomeAndStreamingState)state
{
	UIViewController *destination;
	UIViewController *source;
	switch (state) {
		case RBTHomeState:
			source = self.streamingViewController;
			destination = self.homeViewController;
			break;
		case RBTStreamingState:
			source = self.homeViewController;
			destination = self.streamingViewController;
			break;
	}
	if (source.parentViewController == self) {
		[source removeFromParentViewController];
	}
	if (destination.parentViewController != self) {
		[self addChildViewController:destination withEdgeInsets:UIEdgeInsetsZero inView:self.view];
	}
}

@end
