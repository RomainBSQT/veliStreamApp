//
//  RBTDataEncryptionManager.m
//  veli
//
//  Created by Romain Bousquet on 28/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "RBTDataEncryptionManager.h"

static const NSInteger blockSize = 128;
static const NSInteger blockSizeInBytes = blockSize / 8;

@implementation RBTDataEncryptionManager

+ (NSData *)encryptedDataWithData:(NSData *)data
{
	NSData *result = nil;
	
	NSData *iv = [self salt128bits];
	// The Initialization Vector for AES 256 also serves as the salt for the derived key.
	NSData *key = [self derivedKeyWithSalt:iv];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = data.length + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  key.bytes, kCCKeySizeAES256,
										  iv.bytes,
										  data.bytes, data.length, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	
	if (cryptStatus == kCCSuccess) {
		NSMutableData *resultBuffer = [[NSMutableData alloc] initWithData:iv];
		[resultBuffer appendBytes:buffer length:numBytesEncrypted];
		result = [resultBuffer copy];
	}
	
	free(buffer); //free the buffer;
	
	return result;
}

+ (NSData *)decryptedDataWithData:(NSData *)data
{
	NSData *result = nil;
	
	NSData *iv = [data subdataWithRange:NSMakeRange(0, blockSizeInBytes)];
	// The Initialization Vector for AES 256 also serves as the salt for the derived key.
	NSData *key = [self derivedKeyWithSalt:iv];
	NSData *encryptedData = [data subdataWithRange:NSMakeRange(blockSizeInBytes, data.length - blockSizeInBytes)];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = encryptedData.length + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  key.bytes, kCCKeySizeAES256,
										  iv.bytes,
										  encryptedData.bytes, encryptedData.length, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		result = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	} else {
		free(buffer); //free the buffer;
	}
	
	return result;
}

#pragma mark - Helpers

/**
 * Génère un nouveau NSData aléatoire de 128 bits prévu pour être utilisé pour un salt.
 */
+ (NSData *)salt128bits
{
	unsigned char salt[blockSizeInBytes];
	for (NSUInteger i = 0 ; i < blockSizeInBytes ; i++) {
		salt[i] = (unsigned char)arc4random();
	}
	return [NSData dataWithBytes:salt length:blockSizeInBytes];
}

/**
 * La clé de chiffrement en clair
 */
+ (NSData *)key
{
	NSString *fakeKeyToReplace = @"iopjjfopijefoijqsefpoijq!éèàç!(§)çà(!éà'";
	return [fakeKeyToReplace dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 * Génère une clé dérivée en utilisant pbkdf2 de taille kCCKeySizeAES256
 */
+ (NSData *)derivedKeyWithSalt:(NSData *)salt
{
	NSData *pass = [self key];
	
	const int DerivedKeySize = kCCKeySizeAES256;
	unsigned char key[DerivedKeySize];
	CCKeyDerivationPBKDF(kCCPBKDF2, pass.bytes, pass.length, salt.bytes, salt.length, kCCPRFHmacAlgSHA256, 10000, key, DerivedKeySize);
	
	return [NSData dataWithBytes:key length:DerivedKeySize];
}

@end
