//
//  NUPairedMainBranchAliaser.h
//  Nursery
//
//  Created by P,T,A on 2014/03/15.
//
//

#import "NUMainBranchAliaser.h"

@interface NUPairedMainBranchAliaser : NUMainBranchAliaser
{
    NUU64ODictionary *pupils;
    NUU64ODictionary *fixedOOPToProbationaryPupils;
}

- (NUPairedMainBranchSandbox *)pairedMainBranchSandbox;

@end

@interface NUPairedMainBranchAliaser (Pupil)

- (NSData *)callForPupilWithOOP:(NUUInt64)anOOP containsFellowPupils:(BOOL)aContainsFellowPupils;

- (void)addPupilsDataFromLocation:(NUUInt64)anObjectLocation toData:(NSMutableData *)aData;
- (void)addPupilDataAtLocation:(NUUInt64)anObjectLocation toData:(NSMutableData *)aData;
- (void)addPupilDataWithBellBall:(NUBellBall)aBellBall toData:(NSMutableData *)aData;

- (NSArray *)pupilsFromData:(NSData *)aPupilData;

- (void)setPupils:(NSArray *)aPupils;

- (void)fixProbationaryOOPsInPupils;
- (NUBellBall)fixedBellBallForPupilWithOOP:(NUUInt64)anOOP;
- (void)encodeProbationaryPupils;
- (NUUInt64)allocateObjectSpaceForPupil:(NUPupilNote *)aPupilNote;
- (NSData *)dataWithProbationaryOOPAndFixedOOP;
- (NUUInt64)fixedRootOOPForOOP:(NUUInt64)anOOP;

- (NSString *)descriptionForPupils;

@end
