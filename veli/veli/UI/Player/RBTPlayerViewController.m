//
//  RBTPlayerViewController.m
//  veli
//
//  Created by Romain Bousquet on 11/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTPlayerViewController.h"
#import "UINavigationController+RBT.h"
#import "RBTLiveInformationsView.h"
#import "RBTFriend.h"

@import MediaPlayer;

static CGFloat const kBackIconMargins = 18.f;

@interface RBTPlayerViewController ()

@property (strong, nonatomic) RBTLiveInformationsView *liveInformationView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation RBTPlayerViewController

#pragma mark - Controller Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	[self configurePlayer];
	[self configureSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self layoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.navigationController statusBarAnimateOut];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.player stop];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)configureSubviews
{
	UIImage *backPicture = [UIImage imageNamed:@"icon-hamburger"];
	UIImageView *burgerView = [[UIImageView alloc] initWithImage:backPicture];
	burgerView.userInteractionEnabled = NO;
	burgerView.frame = CGRectMake(kBackIconMargins, kBackIconMargins, backPicture.size.width, backPicture.size.height);
	[self.backButton addSubview:burgerView];
	
	self.liveInformationView = [RBTLiveInformationsView viewFromNib];
	self.liveInformationView.currentFriend = self.streamingFriend;
	self.liveInformationView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.liveInformationView];
	NSArray *verticalConstraints   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==55)]-0-|" options:0 metrics:nil views:@{@"view": self.liveInformationView}];
	NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view": self.liveInformationView}];
	[self.view addConstraints:verticalConstraints];
	[self.view addConstraints:horizontalConstraints];
	
	[self.view bringSubviewToFront:self.liveInformationView];
	[self.view bringSubviewToFront:self.backButton];
}

- (void)configurePlayer
{
	self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://52.28.29.59/lens/testLiveRomain.m3u8"]];
	//http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8
	//http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8
	//http://52.28.29.59/<appname>/<livename>.m3u8
	self.player.movieSourceType = MPMovieSourceTypeStreaming;
	self.player.view.translatesAutoresizingMaskIntoConstraints = NO;
	self.player.controlStyle = MPMovieControlStyleNone;
	self.player.view.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.player.view];
	
	NSDictionary *viewDictionary = @{@"player": self.player.view};
	NSArray *verticalConstraints   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[player]-0-|" options:0 metrics:nil views:viewDictionary];
	NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[player]-0-|" options:0 metrics:nil views:viewDictionary];
	[self.view addConstraints:verticalConstraints];
	[self.view addConstraints:horizontalConstraints];
	[self.player play];
}

- (void)layoutSubviews
{
	
}

#pragma mark - User interactions

- (IBAction)didHitBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
