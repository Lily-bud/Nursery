//
//  NUBranchPeephole.m
//  Nursery
//
//  Created by P,T,A on 2013/09/19.
//
//

#import "NUBranchPeephole.h"
#import "NUBranchNursery.h"
#import "NUBranchPlayLot.h"
#import "NUBranchAliaser.h"
#import "NUPupilNote.h"
#import "NUObjectTable.h"

@implementation NUBranchPeephole

- (id)initWithNursery:(NUNursery *)aNursery playLot:(NUPlayLot *)aPlayLot
{
    if (self = [super initWithNursery:aNursery playLot:aPlayLot])
    {
        nursery = (NUBranchNursery *)aNursery;
        playLot = (NUBranchPlayLot *)aPlayLot;
    }
    
    return self;
}

- (void)peekAt:(NUBellBall)aBellBall
{
    NUBranchAliaser *anAliaser = (NUBranchAliaser *)[playLot aliaser];
    
    currentFixedOOPIvarIndex = 0;
	currentIndexedOOPIndex = 0;
    indexedOOPCount = 0;

    if (aBellBall.oop != NUNilOOP)
    {
        [pupilNote release];
        pupilNote = [[anAliaser callForPupilNoteWithBellBall:aBellBall] retain];
        
        NUUInt64 aCharacterOOP = [pupilNote readUInt64At:0];
        character = [playLot objectForOOP:aCharacterOOP];
        if ([character isIndexedIvars] || [character isFixedAndIndexedIvars])
            indexedOOPCount = [pupilNote readUInt64At:sizeof(NUUInt64)] / sizeof(NUUInt64);
    }
    else
    {
        [pupilNote release];
        pupilNote = nil;
    }
}

- (NUUInt64)nextFixedOOP
{
    NUIvar *anIvar = [[self character] ivarInAllOOPIvarsAt:currentFixedOOPIvarIndex++];
    return [pupilNote readUInt64At:[anIvar offset]];
}

- (NUUInt64)nextIndexedOOP
{
    return [pupilNote readUInt64At:[[self character] indexedIvarOffset] + sizeof(NUUInt64) * currentIndexedOOPIndex++];
}

@end