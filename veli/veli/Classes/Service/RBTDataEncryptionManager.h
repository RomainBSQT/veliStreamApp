//
//  RBTDataEncryptionManager.h
//  veli
//
//  Created by Romain Bousquet on 28/06/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBTDataEncryptionManager : NSObject

+ (NSData *)encryptedDataWithData:(NSData *)data;
+ (NSData *)decryptedDataWithData:(NSData *)data;

@end
