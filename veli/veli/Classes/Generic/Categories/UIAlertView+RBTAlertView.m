//
//  UIAlertView+RBTAlertView.m
//  veli
//
//  Created by Romain Bousquet on 26/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "UIAlertView+RBTAlertView.h"

@implementation UIAlertView (RBTAlertView)

+ (NSString *)defaultWarningTitle
{
	return @"Beware";
}

+ (void)showAlertViewWithWarningTitleAndMessage:(NSString *)message
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self defaultWarningTitle] message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	});
}

@end
