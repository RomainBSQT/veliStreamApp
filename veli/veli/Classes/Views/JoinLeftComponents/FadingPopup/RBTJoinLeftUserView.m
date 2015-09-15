//
//  RBTJoinLeftUserView.m
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTJoinLeftUserView.h"
#import "RBTJoinLeftInformations.h"
#import "RBTFriend.h"

@interface RBTJoinLeftUserView ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;

@end

@implementation RBTJoinLeftUserView

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.title.font = [RBTTheme sourceSansProBoldWithSize:15.f];
	self.letterLabel.font = [RBTTheme sourceSansProBoldWithSize:35.f];
	self.letterLabel.textColor = [UIColor whiteColor];
}

- (void)setupViewFriendInformations:(RBTJoinLeftInformations *)friendInformations;
{
	self.picture.hidden = (friendInformations.currentFriend == nil);
	self.placeholderView.hidden = (friendInformations.currentFriend != nil);
	self.letterLabel.text = [[friendInformations.username substringToIndex:1] uppercaseString];
	self.placeholderView.backgroundColor = friendInformations.color;
	
	NSString *suffixForTitle = @"";
	switch (friendInformations.eventType) {
		case RBTEventTypeJoin:
			suffixForTitle = NSLocalizedString(@"joined", nil);
			self.backgroundColor = [RBTTheme colorGreenEmerald];
			break;
		case RBTEventTypeLeft:
			suffixForTitle = NSLocalizedString(@"left", nil);
			self.backgroundColor = [RBTTheme colorDarkRed];
			break;
	}
	
	NSString *completeString = [NSString stringWithFormat:@"%@ %@", friendInformations.username, suffixForTitle];
	NSMutableAttributedString *formatedString = [[NSMutableAttributedString alloc] initWithString:completeString];
	NSRange suffixRange = [completeString rangeOfString:suffixForTitle];
	[formatedString addAttribute:NSFontAttributeName value:[RBTTheme sourceSansProRegularWithSize:15.f] range:suffixRange];
	self.title.attributedText = formatedString;
}

@end
