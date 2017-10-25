//
//  NULengthTree.h
//  Nursery
//
//  Created by P,T,A on 10/09/16.
//  Copyright 2010 Nursery-Framework. All rights reserved.
//

#import <Nursery/NURegionTree.h>

@class NULocationTree, NULengthTreeLeaf;

@interface NULengthTree : NURegionTree
{
	NULocationTree *locationTree;
}

- (id)initWithRootLocation:(NUUInt64)aRootLocation on:(NUSpaces *)aSpaces;

- (NULengthTreeLeaf *)getNodeContainingSpaceOfLengthGreaterThanOrEqual:(NUUInt64)aLength keyIndex:(NUUInt32 *)aKeyIndex;

- (void)setRegion:(NURegion)aRegion;
- (void)removeRegion:(NURegion)aRegion;

@end