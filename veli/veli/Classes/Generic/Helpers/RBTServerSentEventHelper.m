//
//  RBTServerSentEventHelper.m
//  veli
//
//  Created by Romain Bousquet on 31/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RBTServerSentEventHelper.h"
#import "RBTJoinLeftInformations.h"
#import "NSString+RBT.h"

NSString *const kMainEventName = @"message";

@implementation RBTServerSentEventDatas

+ (instancetype)eventDatasWithEventArray:(NSArray *)eventArray audience:(NSNumber *)audience
{
	RBTServerSentEventDatas *eventDatas = [[RBTServerSentEventDatas alloc] init];
	eventDatas.eventsArray = eventArray;
	eventDatas.audience = audience;
	return eventDatas;
}

@end

@interface RBTServerSentEventHelper ()

@property (strong, nonatomic) EventSource *source;

@end

@implementation RBTServerSentEventHelper

+ (instancetype)SSEWithUrl:(NSURL *)url
{
	RBTServerSentEventHelper *eventHelper = [[RBTServerSentEventHelper alloc] init];
	NCLog(@"SSE: Connecting to :[%@]", url);
	eventHelper.source = [EventSource eventSourceWithURL:url];
	return eventHelper;
}

#pragma mark - Public methods

- (RACSignal *)onEvent:(NSString *)eventName
{
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[self onEvent:eventName handler:^(id<RBTServerSentEventProtocol> eventDatas) {
			[subscriber sendNext:eventDatas];
		}];
		[self onError:^(NSError *error) {
			[subscriber sendError:error];
		}];
		return nil;
	}];
}

#pragma mark - Private methods

- (void)onEvent:(NSString *)eventName handler:(RBTServerSentEvent)handler
{
	[self.source addEventListener:eventName handler:^(Event *event) {
		if ([event.data isEqualToString:@"{}"]) {
			return;
		}
		NSLog(@"SSE EVENT[%@] : %@|%@", eventName, event.event, event.data);
		if (!handler) {
			return;
		}
		NSMutableArray *userArray = [NSMutableArray new];
		NSDictionary *dictEvent = [event.data dictionaryRepresentation];
		if (dictEvent) {
			if ([dictEvent nonNullObjectForKey:@"joined"]) {
				[[dictEvent nonNullObjectForKey:@"joined"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
					RBTJoinLeftInformations *user = [RBTJoinLeftInformations instanceWithEventType:RBTEventTypeJoin username:obj];
					[userArray addObject:user];
				}];
			}
			if ([dictEvent nonNullObjectForKey:@"left"]) {
				[[dictEvent nonNullObjectForKey:@"left"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
					RBTJoinLeftInformations *user = [RBTJoinLeftInformations instanceWithEventType:RBTEventTypeLeft username:obj];
					[userArray addObject:user];
				}];
			}
		}
		handler([RBTServerSentEventDatas eventDatasWithEventArray:userArray
														 audience:[dictEvent nonNullObjectForKey:@"audience"]]);
	}];
}

- (void)onOpen:(EventSourceEventHandler)handler
{
	[self.source onOpen:^(Event *event) {
		NCLog(@"SSE OPEN : %@", event.event);
		if (handler) {
			handler(event);
		}
	}];
}

- (void)onError:(RBTServerSentError)handler
{
	[self.source onError:^(Event *event) {
		NCLog(@"SSE ERROR : %@", event.error);
		if (handler) {
			handler(event.error);
		}
	}];
}

@end
