//
//  NSData.m
//  Nursery
//
//  Created by P,T,A on 2013/11/17.
//
//

#import "NUNSData.h"
#import "NUCharacter.h"
#import "NUPlayLot.h"
#import "NUDataCoder.h"

@implementation NSData (NUCharacter)

+ (BOOL)automaticallyEstablishCharacter
{
    return [self isEqual:[NSData class]] || [self isEqual:[NSMutableData class]];
}

+ (void)defineCharacter:(NUCharacter *)aCharacter on:(NUPlayLot *)aPlayLot
{
    if ([self isEqual:[NSData class]])
    {
        [aCharacter setIsMutable:NO];
    }
    
    [aCharacter setFormat:NUIndexedBytes];
    [aCharacter setCoderClass:[NUDataCoder class]];
}

- (NUUInt64)indexedIvarsSize
{
    return [self length];
}

@end