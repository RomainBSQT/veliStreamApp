//
//  RBTPreLiveViewController.m
//  veli
//
//  Created by Romain Bousquet on 04/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "RBTPreLiveViewController.h"
#import "UINavigationController+RBT.h"
#import "RBTAVCamHelper.h"
#import "RBTFriendsInviteViewController.h"
#import "RBTHomeAndStreamingViewController.h"

static CGFloat const kBurgerMenuIconMargins = 18.f;

@interface RBTPreLiveViewController ()

@property (weak, nonatomic) IBOutlet UIButton *burgerMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *goLiveButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RBTPreLiveViewController

#pragma mark - Controller Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self configureSubviews];
	[self configureCamera];
	[self layoutCamera];
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

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	[[RBTAVCamHelper sharedInstance] startRunning];
}

- (void)removeFromParentViewController
{
	[super removeFromParentViewController];
	[[RBTAVCamHelper sharedInstance] stopRunning];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)configureSubviews
{
	UIImage *burgerPicture = [UIImage imageNamed:@"icon-hamburger"];
	UIImageView *burgerView = [[UIImageView alloc] initWithImage:burgerPicture];
	burgerView.userInteractionEnabled = NO;
	burgerView.frame = CGRectMake(kBurgerMenuIconMargins, kBurgerMenuIconMargins, burgerPicture.size.width, burgerPicture.size.height);
	[self.burgerMenuButton addSubview:burgerView];
}

- (void)configureCamera
{
	[self.activityIndicator startAnimating];
	[[RBTAVCamHelper sharedInstance] configure];
}

- (void)layoutCamera
{
	[[RBTAVCamHelper sharedInstance] layoutCamera:^(AVCaptureVideoPreviewLayer *layer) {
		layer.frame = self.view.bounds;
		[self.view.layer addSublayer:layer];
		[self.activityIndicator stopAnimating];
		[self.view bringSubviewToFront:self.burgerMenuButton];
		[self.view bringSubviewToFront:self.goLiveButton];
	}];
}

#pragma mark - User interactions

- (IBAction)didHitBurgerButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didHitGoLiveButton:(id)sender
{
	[self.delegate showFriendList];
}

@end