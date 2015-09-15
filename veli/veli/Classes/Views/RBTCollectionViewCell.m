//
//  RBTCollectionViewCell.m
//  veli
//
//  Created by Romain Bousquet on 03/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTCollectionViewCell.h"

@implementation RBTCollectionViewCell

+ (NSString *)reuseIdentifier
{
	return [NSString stringWithFormat:@"%@reuseIdentifier", NSStringFromClass([self class])];
}

@end
