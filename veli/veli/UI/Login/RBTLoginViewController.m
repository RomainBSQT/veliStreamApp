//
//  RBTLoginViewController.m
//  veli
//
//  Created by Romain Bousquet on 24/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTLoginViewController.h"
#import "RBTSessionHelper.h"
#import "RBTAppDelegate.h"

@interface RBTLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *connectionButton;
@property (weak, nonatomic) IBOutlet UILabel *facebookDisclaimer;

@end

@implementation RBTLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)configureSubviews
{
	self.facebookDisclaimer.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
	self.facebookDisclaimer.font = [RBTTheme sourceSansProRegularWithSize:15.f];
	self.facebookDisclaimer.text = NSLocalizedString(@"No activity will be shared on Facebook", nil);
}

#pragma mark - User interactions

- (IBAction)didTouchConnectionButton:(id)sender
{
	[[RBTSessionHelper sharedInstance] login:^(id ret) {
		[(RBTAppDelegate *)[[UIApplication sharedApplication] delegate] showHome];
	} failure:^(NSError *error) {
		
	}];
}

@end
