//
//  NSString+RBT.m
//  veli
//
//  Created by Romain Bousquet on 05/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "NSString+RBT.h"

@implementation NSString (RBT)

- (NSDictionary *)dictionaryRepresentation
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	if (error) {
		NCLog(@"Parsing Error on [%@]:%@", self, error.localizedDescription);
		return nil;
	}
	return dict;
}

@end
