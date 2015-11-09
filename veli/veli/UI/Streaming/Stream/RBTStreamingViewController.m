//
//  RBTStreamingViewController.m
//  veli
//
//  Created by Romain Bousquet on 25/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "VCSimpleSession.h"

#import "RBTStreamingViewController.h"
#import "UINavigationController+RBT.h"
#import "RBTLiveInformationsView.h"
#import "RBTPreLiveViewController.h"
#import "RBTHomeAndStreamingViewController.h"
#import "RBTJoinLeftViewController.h"
#import "RBTViewersViewController.h"
#import "RBTJoinLeftInformations.h"
#import "RBTServerSentEventHelper.h"
#import "RBTURLBuilder.h"
#import "RBTFriend.h"
#import "RBTUser.h"

//-- Streaming consts
static NSInteger const kBitRate = 1000000;
static NSInteger const kFrameRate = 30;

static CGFloat const kBackIconMargins = 18.f;

@interface RBTStreamingViewController () <VCSessionDelegate>

@property (strong, nonatomic) VCSimpleSession *session;

@property (weak, nonatomic) IBOutlet UIButton *switchCamButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *streamView;
@property (weak, nonatomic) IBOutlet UIView *joinLeftView;
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *informationView;

@property (strong, nonatomic) RBTLiveInformationsView *liveInformationView;
@property (strong, nonatomic) RBTJoinLeftViewController *joinLeftController;
@property (strong, nonatomic) RBTViewersViewController *viewersController;
@property (strong, nonatomic) RBTServerSentEventHelper *SSEEvents;

@end

@implementation RBTStreamingViewController

#pragma mark - Controller life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
//	[self configureSSE];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.navigationController statusBarAnimateOut];
	[self connectStream];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.joinLeftController reset];
}

#pragma mark - Setup

- (void)configureSubviews
{
	self.streamView.backgroundColor = [UIColor blackColor];
	self.view.backgroundColor = [UIColor blackColor];
	
	[self configureButtons];
	[self configureInformationView];
	[self configureJoinLeftController];
	[self configureCollectionView];
	
	[self.view bringSubviewToFront:self.liveInformationView];
	[self.view bringSubviewToFront:self.backButton];
	[self.view bringSubviewToFront:self.switchCamButton];
	[self.view bringSubviewToFront:self.joinLeftView];
}

- (void)configureSSE
{
	self.SSEEvents = [RBTServerSentEventHelper SSEWithUrl:[NSURL URLWithString:[RBTURLBuilder SSEURLSubscribe]]];
	[self startSSE];
}

- (void)startSSE
{
	@weakify(self)
	[[self.SSEEvents onEvent:kMainEventName] subscribeNext:^(NSDictionary *eventDatas) {
		@strongify(self)
		[self pushUsers:eventDatas[@"events"]];
	} error:^(NSError *error) {
		@strongify(self)
		if (error.code == -1001) { //-- Timeout
			[self startSSE];
		}
	}];
}

- (void)pushUsers:(NSArray *)userArray
{
	[userArray enumerateObjectsUsingBlock:^(RBTJoinLeftInformations *obj, NSUInteger idx, BOOL *stop) {
		[self.joinLeftController addFriendForAnimation:obj];
		[self.viewersController addFriendForAnimation:obj];
	}];
}

- (void)configureButtons
{
	UIImage *burgerPicture = [UIImage imageNamed:@"icon-cross-white"];
	UIImageView *burgerView = [[UIImageView alloc] initWithImage:burgerPicture];
	burgerView.userInteractionEnabled = NO;
	burgerView.frame = CGRectMake(kBackIconMargins, kBackIconMargins, burgerPicture.size.width, burgerPicture.size.height);
	self.backButton.backgroundColor = [UIColor clearColor];
	[self.backButton addSubview:burgerView];
	
	UIImage *reloadPicture = [UIImage imageNamed:@"icon-switch"];
	UIImageView *switchView = [[UIImageView alloc] initWithImage:reloadPicture];
	switchView.userInteractionEnabled = NO;
	switchView.frame = CGRectMake(CGRectGetMaxX(self.switchCamButton.bounds) - kBackIconMargins - reloadPicture.size.width, kBackIconMargins, reloadPicture.size.width, reloadPicture.size.height);
	self.switchCamButton.backgroundColor = [UIColor clearColor];
	[self.switchCamButton addSubview:switchView];
}

- (void)configureInformationView
{
	self.informationView.backgroundColor = [UIColor clearColor];
	self.informationView.translatesAutoresizingMaskIntoConstraints = NO;
	self.liveInformationView = [RBTLiveInformationsView viewFromNib];
	
//-- Debug
	self.liveInformationView.currentFriend = self.invitedFriends[0];
//--
	
	self.liveInformationView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.informationView addSubview:self.liveInformationView];
	[self.liveInformationView setConstraintsFillSuperView:self.informationView];
}

- (void)configureJoinLeftController
{
	self.joinLeftView.backgroundColor = [UIColor clearColor];
	self.joinLeftController = [[RBTJoinLeftViewController alloc] init];
	self.joinLeftController.view.translatesAutoresizingMaskIntoConstraints = NO;
	self.joinLeftView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.joinLeftView addSubview:self.joinLeftController.view];
	[self.joinLeftController.view setConstraintsFillSuperView:self.joinLeftView];
}

- (void)configureCollectionView
{
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.viewersController = [[RBTViewersViewController alloc] init];
	self.viewersController.view.translatesAutoresizingMaskIntoConstraints = NO;
	[self.collectionView addSubview:self.viewersController.view];
	[self.viewersController.view setConstraintsFillSuperView:self.collectionView];
}

#pragma mark - Stream functions

- (void)configureStream
{
	if (self.session != nil) {
		return;
	}
	self.session = [[VCSimpleSession alloc] initWithVideoSize:self.streamView.bounds.size frameRate:kFrameRate bitrate:kBitRate useInterfaceOrientation:YES cameraState:VCCameraStateFront];
	self.session.delegate = self;
	self.session.previewView.frame = self.streamView.bounds;
	[self.streamView addSubview:self.session.previewView];
}

- (void)connectStream
{
	if (!self.session) {
		[self configureStream];
	}
	if ([self isSessionRunning]) {
		return;
	}
//	NSString *host = @"rtmp://publish.dailymotion.com/publish-dm";
//	NSString *streamUrl = @"x1r0624?auth=1713954118_1eff03da516e2e35dc8bc72338253697";
	NSString *host = @"rtmp://52.28.29.59/lens/bonjourbonjoudqdr";

	[self.session startRtmpSessionWithURL:host andStreamKey:@"bonjourbonjoudqdr"];
	[self refreshStream];
}

- (void)disconnectStream
{
	[self.session endRtmpSession];
}

- (void)refreshStream
{
	//-- TODO : Clean this hack
	[self switchCameras];
	[self switchCameras];
}

- (void)switchCameras
{
	self.session.cameraState = (self.session.cameraState == VCCameraStateBack) ? VCCameraStateFront : VCCameraStateBack;
}

#pragma mark - VCSessionDelegate

- (void)connectionStatusChanged:(VCSessionState)sessionState
{
	NCLog(@"Stream status changed : %@", [self stringFromState:sessionState]);
	switch (sessionState) {
		case VCSessionStateNone:
			break;
		case VCSessionStatePreviewStarted:
			break;
		case VCSessionStateStarting:
			break;
		case VCSessionStateStarted:
			break;
		case VCSessionStateError:
			[self showAlert:NSLocalizedString(@"The streaming encountered an error, sorry about that.", nil)];
		case VCSessionStateEnded:
			[self.delegate switchToState:RBTHomeState];
			break;
		default:
			break;
	}
}

#pragma mark - User interactions

- (IBAction)backButtonHit:(id)sender
{
	[self disconnectStream];
}

- (IBAction)switchCamButtonHit:(id)sender
{
	[self switchCameras];
}

- (void)showAlert:(NSString *)message
{
	[UIAlertView showAlertViewWithWarningTitleAndMessage:message];
}

#pragma mark - Helpers

- (BOOL)isSessionRunning
{
	return self.session.rtmpSessionState == VCSessionStateStarted || self.session.rtmpSessionState == VCSessionStateStarting;
}

- (NSString *)stringFromState:(VCSessionState)state
{
	switch (state) {
		case VCSessionStateNone:
			return @"VCSessionStateNone";
		case VCSessionStatePreviewStarted:
			return @"VCSessionStatePreviewStarted";
		case VCSessionStateStarting:
			return @"VCSessionStateStarting";
		case VCSessionStateStarted:
			return @"VCSessionStateStarted";
		case VCSessionStateEnded:
			return @"VCSessionStateEnded";
		case VCSessionStateError:
			return @"VCSessionStateError";
		default:
			return nil;
	}
}

@end
