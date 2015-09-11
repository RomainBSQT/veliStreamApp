//
//  RBTAVCamHelper.h
//  veli
//
//  Created by Romain Bousquet on 05/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^RBTCamLayoutSuccess)(AVCaptureVideoPreviewLayer *);

@interface RBTAVCamHelper : NSObject

+ (instancetype)sharedInstance;
- (void)configure;
- (void)layoutCamera:(RBTCamLayoutSuccess)success;
- (void)startRunning;
- (void)stopRunning;

@end