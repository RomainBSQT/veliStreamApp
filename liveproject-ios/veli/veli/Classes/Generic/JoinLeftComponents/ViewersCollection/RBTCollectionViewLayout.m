//
//  RBTCollectionViewLayout.m
//  veli
//
//  Created by Romain Bousquet on 04/05/2015.
//  Copyright (c) 2015 Romain Bousquet. All rights reserved.
//

#import "RBTCollectionViewLayout.h"

@interface RBTCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray *insertedIndexPaths;
@property (nonatomic, strong) NSMutableArray *removedIndexPaths;
@property (nonatomic, strong) NSMutableDictionary *currentCellAttributes;
@property (nonatomic, strong) NSMutableDictionary *cachedCellAttributes;

@end

@implementation RBTCollectionViewLayout

- (id)init
{
	self = [super init];
	if (self) {
		self.insertedIndexPaths = [NSMutableArray new];
		self.removedIndexPaths = [NSMutableArray new];
		self.currentCellAttributes = [NSMutableDictionary new];
		self.cachedCellAttributes = [NSMutableDictionary new];
	}
	return self;
}

//- (void)prepareLayout
//{
//	[super prepareLayout];
//}
//
//- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
//{
//	[super prepareForCollectionViewUpdates:updateItems];
//	
//	[updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger idx, BOOL *stop) {
//		if (updateItem.updateAction == UICollectionUpdateActionInsert) {
//			[self.insertedIndexPaths addObject:updateItem.indexPathAfterUpdate];
//		} else if (updateItem.updateAction == UICollectionUpdateActionDelete) {
//			[self.removedIndexPaths addObject:updateItem.indexPathBeforeUpdate];
//		}
//	}];
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//	NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
//	[attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
//		if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
//			[self.currentCellAttributes setObject:attributes forKey:attributes.indexPath];
//		}
//	}];
//	return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//	UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//	return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//	UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
//	return attributes;
//}

@end
