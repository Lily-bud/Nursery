//
//  NUMainBranchAperture.h
//  Nursery
//
//  Created by P,T,A on 2013/09/19.
//
//

#import "NUAperture.h"

@class NUMainBranchNursery, NUMainBranchSandbox;

@interface NUMainBranchAperture : NUAperture
{
    NUMainBranchNursery *nursery;
    NUMainBranchSandbox *sandbox;
	NUUInt64 oop;
	NUUInt64 objectLocation;
}
@end