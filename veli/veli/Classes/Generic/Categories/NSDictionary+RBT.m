//
//  NSDictionary+RBT.m
//  veli
//
//  Created by Romain Bousquet on 21/03/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "NSDictionary+RBT.h"

@implementation NSDictionary (RBT)

- (id)nonNullObjectForKey:(id)key
{
	id obj = [self objectForKey:key];
	if (obj == [NSNull null]) {
		return nil;
	}
	return obj;
}

@end