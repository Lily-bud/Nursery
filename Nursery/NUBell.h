//
//  NUBell.h
//  Nursery
//
//  Created by Akifumi Takata on 11/02/24.
//  Copyright 2011 Nursery-Framework. All rights reserved.
//

#import <Foundation/NSObject.h>

#import "NUTypes.h"

@class NUGarden;


@interface NUBell : NSObject <NSCopying>
{
	NUBellBall ball;
    NUUInt64 gradeAtCallFor;
    NUUInt64 gradeForSeeker;
	NUGarden *garden;
    BOOL isLoaded;
	id object;
}

+ (id)bellWithBall:(NUBellBall)aBall;
+ (id)bellWithBall:(NUBellBall)aBall garden:(NUGarden *)aGarden;
+ (id)bellWithBall:(NUBellBall)aBall isLoaded:(BOOL)anIsLoaded garden:(NUGarden *)aGarden;

- (id)initWithBall:(NUBellBall)aBall isLoaded:(BOOL)anIsLoaded garden:(NUGarden *)aGarden;

- (NUBellBall)ball;
- (void)setBall:(NUBellBall)aBall;

- (NUUInt64)OOP;
- (void)setOOP:(NUUInt64)anOOP;

- (NUUInt64)grade;
- (void)setGrade:(NUUInt64)aGrade;

- (NUUInt64)gradeAtCallFor;
- (void)setGradeAtCallFor:(NUUInt64)aGrade;

- (NUUInt64)gradeForSeeker;
- (void)setGradeForSeeker:(NUUInt64)aGrade;

- (NUGarden *)garden;
- (void)setGarden:(NUGarden *)aGarden;

- (id)object;
- (void)setObject:(id)anObject;

- (id)loadObject;

- (BOOL)isLoaded;
- (BOOL)hasObject;
- (BOOL)isEqualToBell:(NUBell *)anOOP;

- (void)markChanged;

- (void)invalidate;
- (void)invalidateObjectIfNotReferenced;

@end

@interface NUBell (Private)

- (void)setIsLoaded:(BOOL)aLoadedFlag;

@end

@interface NSObject (NUBell)

- (BOOL)isBell;

@end
