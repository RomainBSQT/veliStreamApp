//
//  NSMutableArray+RBT.m
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "NSMutableArray+RBT.h"

@implementation NSMutableArray (RBT)

- (id)queuePop
{
	if (self.count == 0) {
		return nil;
	}
	id poppedObject = [self firstObject];
	[self removeObjectAtIndex:0];
	return poppedObject;
}

- (void)queuePush:(id)object
{
	[self addObject:object];
}

@end
