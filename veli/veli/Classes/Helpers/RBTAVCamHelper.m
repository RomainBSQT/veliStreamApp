//
//  RBTAVCamHelper.m
//  veli
//
//  Created by Romain Bousquet on 05/04/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTAVCamHelper.h"

@interface RBTAVCamHelper ()

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *layer;
@property (assign, atomic) BOOL isConfigured;
@property (nonatomic) dispatch_queue_t sessionQueue;

@end

@implementation RBTAVCamHelper

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
	static RBTAVCamHelper *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [RBTAVCamHelper new];
	});
	return sharedInstance;
}

- (id)init
{
	self = [super init];
	if (self) {
		_isConfigured = NO;
		_session = [[AVCaptureSession alloc] init];
		_sessionQueue = dispatch_queue_create("session_queue", DISPATCH_QUEUE_SERIAL);
	}
	return self;
}

- (void)configure
{
	if (self.isConfigured) {
		return;
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		AVCaptureDevice *videoCaptureDevice = [[self class] deviceWithMediaType:AVMediaTypeVideo
															 preferringPosition:AVCaptureDevicePositionFront];
		NSError *error = nil;
		AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
		if (videoInput && [self.session canAddInput:videoInput]) {
			[self.session addInput:videoInput];
		} else {
			NCLog(@"AVCaptureDeviceInput ERROR");
		}
		self.isConfigured = YES;
	});
}

- (void)layoutCamera:(RBTCamLayoutSuccess)success
{
	dispatch_async(dispatch_get_main_queue(), ^{
		if (!self.layer) {
			self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
		}
		if (success) {
			success(self.layer);
		}
	});
}

- (void)startRunning
{
	if (self.session.isRunning) {
		return;
	}
	dispatch_async(dispatch_get_main_queue(), ^{
		if (!self.session.isRunning) {
			[self.session startRunning];
		}
	});
}

- (void)stopRunning
{
	if (!self.session.isRunning) {
		return;
	}
	dispatch_async(self.sessionQueue, ^{
		[self.session stopRunning];
	});
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
	NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
	AVCaptureDevice *captureDevice = [devices firstObject];
	
	for (AVCaptureDevice *device in devices) {
		if ([device position] == position) {
			captureDevice = device;
			break;
		}
	}
	return captureDevice;
}

@end
