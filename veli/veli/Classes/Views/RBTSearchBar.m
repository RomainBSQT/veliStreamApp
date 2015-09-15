//
//  RBTSearchBar.m
//  veli
//
//  Created by Romain Bousquet on 27/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTSearchBar.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+RBT.h"

@interface RBTSearchBar () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet RBTTextField *textField;

@end

@implementation RBTSearchBar

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.backgroundColor = [UIColor clearColor];
	
	UIImage *iconSearch = [UIImage imageNamed:@"icon-search"];
	UIImageView *leftView = [[UIImageView alloc] initWithImage:iconSearch];
	leftView.contentMode = UIViewContentModeCenter;
	leftView.frame = CGRectMake(0, 0, iconSearch.size.width+20.f, iconSearch.size.height);
	self.textField.leftViewMode = UITextFieldViewModeAlways;
	self.textField.leftView = leftView;
	self.textField.delegate = self;
	self.textField.font = [RBTTheme sourceSansProRegularWithSize:15.f];
	self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.textField.layer.borderWidth = 1.f;
	self.textField.layer.cornerRadius = 4.f;
	self.textField.placeholder = NSLocalizedString(@"Search usernames", nil);
	[self setIdleState];
}

- (void)setSelectedState
{
	self.textField.layer.borderColor = [[RBTTheme colorDarkGray] CGColor];
	self.textField.textColor = [RBTTheme colorDarkGray];
	self.textField.tintColor = [RBTTheme colorDarkGray];
}

- (void)setIdleState
{
	self.textField.layer.borderColor = [[RBTTheme colorLightGray] CGColor];
	self.textField.textColor = [RBTTheme colorLightGray];
	self.textField.tintColor = [RBTTheme colorLightGray];
}

- (void)dismissKeyboard
{
	[self setIdleState];
	[self.textField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self setSelectedState];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self dismissKeyboard];
	return YES;
}

@end