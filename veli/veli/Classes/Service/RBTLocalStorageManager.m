//
//  RBTLocalStorageManager.m
//  veli
//
//  Created by Romain Bousquet on 27/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTLocalStorageManager.h"
#import "RBTUser.h"
#import "RBTDataEncryptionManager.h"

@implementation RBTLocalStorageManager

+ (RBTUser *)currentUser
{
	NSData *encryptedProfile = [[NSUserDefaults standardUserDefaults] objectForKey:[self userDefaultsKey]];
	if (!encryptedProfile) {
		return nil;
	}
	NSData *decryptedProfile = [RBTDataEncryptionManager decryptedDataWithData:encryptedProfile];
	RBTUser *currentProfile = [NSKeyedUnarchiver unarchiveObjectWithData:decryptedProfile];
	return currentProfile;
}

+ (BOOL)isUserExisting
{
	return [self currentUser] != nil;
}

+ (void)save:(RBTUser *)user
{
	NSData *serializedProfile = [NSKeyedArchiver archivedDataWithRootObject:user];
	NSData *encryptedProfile = [RBTDataEncryptionManager encryptedDataWithData:serializedProfile];
	[[NSUserDefaults standardUserDefaults] setObject:encryptedProfile forKey:[self userDefaultsKey]];
}

#pragma mark - Helpers

+ (NSString *)userDefaultsKey
{
	return @"userProfile";
}

@end
