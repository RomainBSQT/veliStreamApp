//
//  RBTJoinLeftViewController.m
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTJoinLeftViewController.h"
#import "RBTJoinLeftUserView.h"
#import "RBTFriend.h"
#import "NSMutableArray+RBT.h"

typedef void (^RBTAnimationComplete)();

static CGFloat const kJoinStartStateAnimationXPosition  = -50.f;
static CGFloat const kJoinMiddleStateAnimationXPosition = 18.f;
static CGFloat const kJoinEndStateAnimationXPosition    = 40.f;
static CGFloat const kLeftStartStateAnimationXPosition  = 40.f;
static CGFloat const kLeftMiddleStateAnimationXPosition = 18.f;
static CGFloat const kLeftEndStateAnimationXPosition    = -50.f;
static CGFloat const kLastingTime = 1.5f;

typedef NS_ENUM(NSUInteger, RBTAnimationState) {
	RBTAnimationStateNone,
	RBTAnimationStateMovingIn,
	RBTAnimationStateMiddleStill,
	RBTAnimationStateMovingOut
};

@interface RBTJoinLeftViewController ()

@property (strong, atomic) NSMutableArray *queue;
@property (assign, atomic) RBTAnimationState animationState;
@property (strong, nonatomic) RBTJoinLeftUserView *animatedView;
@property (strong, nonatomic) NSLayoutConstraint *animationConstraint;

@end

@implementation RBTJoinLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];
	self.animationState = RBTAnimationStateNone;
	
	self.queue = [NSMutableArray new];
	
	self.animatedView = [RBTJoinLeftUserView viewFromNib];
	self.animatedView.translatesAutoresizingMaskIntoConstraints = NO;
	self.animatedView.clipsToBounds = YES;
	self.animatedView.userInteractionEnabled = NO;
	self.animatedView.layer.cornerRadius = 4.f;
	[self.view addSubview:self.animatedView];
	[self.animatedView setConstraintsForXCenteringInView:self.view];
	
	self.animationConstraint = [NSLayoutConstraint constraintWithItem:self.animatedView
															attribute:NSLayoutAttributeTop
															relatedBy:NSLayoutRelationEqual
															   toItem:self.view
															attribute:NSLayoutAttributeTop
														   multiplier:1.f
															 constant:kJoinStartStateAnimationXPosition];
	[self.view addConstraint:self.animationConstraint];
}

#pragma mark - Public functions

- (void)addFriendForAnimation:(RBTJoinLeftInformations *)newInformation
{
	[self.queue queuePush:newInformation];
	[self playAnimationIfNeeded];
}

- (void)reset
{
	self.animationConstraint.constant = kJoinStartStateAnimationXPosition;
	[self.view layoutIfNeeded];
}

#pragma mark - Animations

- (void)playAnimationIfNeeded
{
	if (!self.animationState == RBTAnimationStateNone) {
		return;
	}
	if (!self.queue.count) {
		return;
	}
	NCLog(@"Current Queue : %@", [self.queue valueForKey:@"eventType"]);
	[self playAnimationWithInfos:[self.queue queuePop]];
}

- (void)playAnimationWithInfos:(RBTJoinLeftInformations *)infos
{
	switch (infos.eventType) {
		case RBTEventTypeJoin:
			[self playJoinAnimationWithInformations:infos];
			break;
		case RBTEventTypeLeft:
			[self playLeftAnimationWithInformations:infos];
	}
}

#pragma mark - Join

- (void)playJoinAnimationWithInformations:(RBTJoinLeftInformations *)infos
{
	if (self.animationState != RBTAnimationStateNone) {
		return;
	}
	[self.animatedView setupViewFriendInformations:infos];
	self.animationState = RBTAnimationStateMovingIn;
	[self joinAnimationIn:^{
		self.animationState = RBTAnimationStateMiddleStill;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kLastingTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			self.animationState = RBTAnimationStateMovingOut;
			[self joinAnimationOut:^{
				self.animationState = RBTAnimationStateNone;
				[self playAnimationIfNeeded];
			}];
		});
	}];
}

- (void)joinAnimationIn:(RBTAnimationComplete)completed
{
	self.animationConstraint.constant = kJoinStartStateAnimationXPosition;
	[self.view layoutIfNeeded];
	
	self.animationConstraint.constant = kJoinMiddleStateAnimationXPosition;
	self.animatedView.alpha = 0.f;
	[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.animatedView.alpha = 1.f;
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (completed) {
			completed();
		}
	}];
}

- (void)joinAnimationOut:(RBTAnimationComplete)completed
{
	if (self.animationConstraint.constant != kJoinMiddleStateAnimationXPosition) {
		return;
	}
	[self.view layoutIfNeeded];
	
	self.animationConstraint.constant = kJoinEndStateAnimationXPosition;
	[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.animatedView.alpha = 0.f;
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (completed) {
			completed();
		}
	}];
}

#pragma mark - Left

- (void)playLeftAnimationWithInformations:(RBTJoinLeftInformations *)infos
{
	if (self.animationState != RBTAnimationStateNone) {
		return;
	}
	[self.animatedView setupViewFriendInformations:infos];
	self.animationState = RBTAnimationStateMovingIn;
	[self leftAnimationIn:^{
		self.animationState = RBTAnimationStateMiddleStill;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kLastingTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			self.animationState = RBTAnimationStateMovingOut;
			[self leftAnimationOut:^{
				self.animationState = RBTAnimationStateNone;
				[self playAnimationIfNeeded];
			}];
		});
	}];
}

- (void)leftAnimationIn:(RBTAnimationComplete)completed
{
	self.animationConstraint.constant = kLeftStartStateAnimationXPosition;
	[self.view layoutIfNeeded];
	
	self.animationConstraint.constant = kLeftMiddleStateAnimationXPosition;
	self.animatedView.alpha = 0.f;
	[UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.animatedView.alpha = 1.f;
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (completed) {
			completed();
		}
	}];
}

- (void)leftAnimationOut:(RBTAnimationComplete)completed
{
	if (self.animationConstraint.constant != kLeftMiddleStateAnimationXPosition) {
		return;
	}
	[self.view layoutIfNeeded];
	
	self.animationConstraint.constant = kLeftEndStateAnimationXPosition;
	[UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.animatedView.alpha = 0.f;
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {
		if (completed) {
			completed();
		}
	}];
}

@end
