//
//  RBTTableViewCell.m
//  veli
//
//  Created by Romain Bousquet on 29/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTTableViewCell.h"

@implementation RBTTableViewCell

+ (NSString *)reuseIdentifier
{
	return [NSString stringWithFormat:@"%@reuseIdentifier", NSStringFromClass([self class])];
}

@end
