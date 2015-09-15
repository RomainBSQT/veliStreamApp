//
//  RBTViewersViewController.m
//  veli
//
//  Created by Romain Bousquet on 02/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTViewersViewController.h"
#import "RBTFriendViewCell.h"
#import "NSMutableArray+RBT.h"
#import "RBTCollectionViewLayout.h"
#import "RBTJoinLeftInformations.h"
#import "RBTFriend.h"

static CGFloat const kInterItemSpacing = 15.f;
static CGFloat const kCellSize = 50.f;

@interface RBTViewersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *friendArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) RBTCollectionViewLayout *collectionLayout;

@end

@implementation RBTViewersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
	self.friendArray = [NSMutableArray new];
	[self configureCollection];
}

- (void)configureCollection
{
	self.collectionLayout = [[RBTCollectionViewLayout alloc] init];
	self.collectionLayout.minimumLineSpacing = kInterItemSpacing;
	self.collectionLayout.minimumInteritemSpacing = kInterItemSpacing;
	self.collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	self.collectionLayout.sectionInset = UIEdgeInsetsMake(0.f, 12.f, 0.f, 0.f);
	self.collectionLayout.itemSize = CGSizeMake(kCellSize, kCellSize);
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.collectionViewLayout = self.collectionLayout;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerNib:[RBTFriendViewCell nib] forCellWithReuseIdentifier:[RBTFriendViewCell reuseIdentifier]];
}

#pragma mark - Public functions

- (void)addFriendForAnimation:(RBTJoinLeftInformations *)newInformation
{
	switch (newInformation.eventType) {
		case RBTEventTypeJoin:
			[self hasJoin:newInformation];
			break;
		case RBTEventTypeLeft:
			[self hasLeft:newInformation];
			break;
	}
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	RBTFriendViewCell *cell = (RBTFriendViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[RBTFriendViewCell reuseIdentifier] forIndexPath:indexPath];
	[cell setupViewFriendInformations:self.friendArray[indexPath.row]];
	return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.friendArray.count;
}

#pragma mark - Insert/delete

- (void)hasLeft:(RBTJoinLeftInformations *)userInformations
{
	if (!userInformations) {
		return;
	}
	if (!self.friendArray.count) {
		return;
	}
	if (![self.friendArray containsObject:userInformations]) {
		return;
	}
	__block NSUInteger index = [self.friendArray indexOfObject:userInformations];
	[self.collectionView performBatchUpdates:^{
		[self.friendArray removeObjectAtIndex:index];
		[self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
	} completion:nil];
}

- (void)hasJoin:(RBTJoinLeftInformations *)userInformations
{
	if (!userInformations) {
		return;
	}
	if (self.friendArray.count && [self.friendArray containsObject:userInformations]) {
		return;
	}
	[self.collectionView performBatchUpdates:^{
		[self.friendArray addObject:userInformations];
		[self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.friendArray.count-1 inSection:0]]];
	} completion:nil];
}

@end
