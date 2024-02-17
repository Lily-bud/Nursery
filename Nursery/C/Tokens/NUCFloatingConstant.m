//
//  NUCFloatingConstant.m
//  Nursery
//
//  Created by TAKATA Akifumi on 2024/02/11.
//

#import "NUCFloatingConstant.h"
#import "NUCDecomposedPreprocessingToken.h"
#import "NUCConstant.h"
#import "NUCDecimalFloatingConstant.h"
#import "NUCFractionalConstant.h"
#import "NUCExponentPart.h"

#import <Foundation/NSString.h>

@implementation NUCFloatingConstant

+ (BOOL)floatingConstantFromPpNumber:(NUCDecomposedPreprocessingToken *)aPpNumber into:(NUCConstant **)aConstant
{
    if (![aPpNumber isPpNumber])
        return NO;
    
    NSString *aString = [aPpNumber content];
    NSString *aDigitSequence = nil, *aDigitSequence2 = nil;
    NSUInteger aLocation = 0;
    
    if ([self fractionalConstantFrom:aString into:&aDigitSequence into:&aDigitSequence2 location:&aLocation])
    {
        NUCExponentPart *anExponentPart = [NUCExponentPart exponentPartWith:aString location:&aLocation];
        
        NSString *aFloatingSuffix = nil;
        [self floatingSuffixFrom:aString into:&aFloatingSuffix location:&aLocation];
        
        NUCFractionalConstant *aFractionalConstant = [NUCFractionalConstant constantWithDigitSequence:aDigitSequence digitSequence2:aDigitSequence2];
        
        NUCDecimalFloatingConstant *aDecimalFloatingConstant = [NUCDecimalFloatingConstant floatingConstantWithFractionalConstant:aFractionalConstant exponentPart:anExponentPart floatingSuffix:aFloatingSuffix ppNumber:aPpNumber];
        
        if (aConstant)
            *aConstant = [NUCConstant constantWithFloatingConstant:aDecimalFloatingConstant];
        
        return YES;
    }
    else
    {
        if ([self digitSequenceFrom:aString at:&aLocation into:&aDigitSequence])
        {
            NUCExponentPart *anExponentPart = [NUCExponentPart exponentPartWith:aString location:&aLocation];
            if (anExponentPart)
            {
                NSString *aFloatingSuffix = nil;
                [self floatingSuffixFrom:aString into:&aFloatingSuffix location:&aLocation];
                
                NUCDecimalFloatingConstant *aDecimalFloatingConstant = [NUCDecimalFloatingConstant floatingConstantWithDigitSequence:aDigitSequence exponentPart:anExponentPart floatingSuffix:aFloatingSuffix ppNumber:aPpNumber];
                
                if (aConstant)
                    *aConstant = [NUCConstant constantWithFloatingConstant:aDecimalFloatingConstant];
                
                return YES;
            }
        }
    }
    
    return NO;
}

+ (BOOL)fractionalConstantFrom:(NSString *)aString into:(NSString **)aDigitSequence into:(NSString  **)aDigitSequence2 location:(NSUInteger *)aLocationPointer
{
    if (!aLocationPointer)
        return NO;
    
    NSRange aDigitSequenceRange = [self rangeOfDigitSequenceFrom:aString];
    NSRange aDigitsRange2 = NSMakeRange(NSNotFound, 0);
    
    if (aDigitSequenceRange.location == 0 && aDigitSequenceRange.length != 0)
    {
        NSUInteger aLocation = NSMaxRange(aDigitSequenceRange);
        if (aLocation < [aString length])
        {
            if ([aString compare:NUCPeriod options:0 range:NSMakeRange(aLocation, 1)] == NSOrderedSame)
            {
                aDigitsRange2 = [self rangeOfDigitSequenceFrom:aString range:NSMakeRange(aLocation + 1, [aString length] - (aLocation + 1))];
                
                if (aDigitSequence)
                    *aDigitSequence = [aString substringWithRange:aDigitSequenceRange];
                
                if (aDigitsRange2.length > 0)
                {
                    if (aDigitSequence2)
                        *aDigitSequence2 = [aString substringWithRange:aDigitsRange2];
                    *aLocationPointer = NSMaxRange(aDigitsRange2);
                }
                else
                {
                    *aLocationPointer = NSMaxRange(aDigitSequenceRange) + 1;
                }
                
                return YES;
            }
        }
    }
    else
    {
        if ([aString hasPrefix:NUCPeriod])
        {
            aDigitSequenceRange = [self rangeOfDigitSequenceFrom:aString range:NSMakeRange(1, [aString length] - 1)];
            
            if (aDigitSequenceRange.location != NSNotFound)
            {
                if (aDigitSequence2)
                    *aDigitSequence2 = [aString substringWithRange:aDigitSequenceRange];
                
                if (aLocationPointer)
                    *aLocationPointer = NSMaxRange(aDigitSequenceRange);
                
                return YES;
            }
        }
    }
    
    return NO;
}

+ (BOOL)signFrom:(NSString *)aString into:(NSString **)aSign location:(NSUInteger *)aLocationPointer
{
    if (!aLocationPointer)
        return NO;
    
    NSUInteger aLocation = *aLocationPointer;
    NSRange aRange = NSMakeRange(aLocation, 1);
    NSString *aSignToReturn = nil;
    
    if ([aString compare:NUCPlusSign options:0 range:aRange] == NSOrderedSame)
        aSignToReturn = NUCPlusSign;
    else if ([aString compare:NUCMinusSign options:0 range:aRange])
        aSignToReturn = NUCMinusSign;
    else
        return NO;
    
    *aLocationPointer = aLocation + 1;
    if (aSign)
        *aSign = aSignToReturn;
    
    return YES;
}

+ (BOOL)floatingSuffixFrom:(NSString *)aString into:(NSString **)aFloatingSuffix location:(NSUInteger *)aLocationPointer
{
    if (!aLocationPointer)
        return NO;
    
    NSUInteger aLocation = *aLocationPointer;
    NSRange aRange = NSMakeRange(aLocation, 1);
    NSString *aSuffixToReturn = nil;
    
    if ([aString compare:NUCSmallF options:0 range:aRange] == NSOrderedSame)
        aSuffixToReturn = NUCSmallF;
    else if ([aString compare:NUCSmallL options:0 range:aRange] == NSOrderedSame)
        aSuffixToReturn = NUCSmallL;
    else if ([aString compare:NUCLargeF options:0 range:aRange] == NSOrderedSame)
        aSuffixToReturn = NUCLargeF;
    else if ([aString compare:NUCLargeL options:0 range:aRange] == NSOrderedSame)
        aSuffixToReturn = NUCLargeL;
    else
        return NO;
    
    if (aFloatingSuffix)
        *aFloatingSuffix = aSuffixToReturn;
    *aLocationPointer = aLocation + 1;
    
    return YES;
}

+ (BOOL)digitSequenceFrom:(NSString *)aString at:(NSUInteger *)aLocationPointer into:(NSString **)aDigitSequence
{
    if (!aLocationPointer)
        return NO;
    
    NSUInteger aLocation = *aLocationPointer;
    NSRange aDigitSequenceRange = [self rangeOfDigitSequenceFrom:aString range:NSMakeRange(aLocation, [aString length] - aLocation)];
    
    if (aDigitSequenceRange.location != NSNotFound)
    {
        if (aDigitSequence)
            *aDigitSequence = [aString substringWithRange:aDigitSequenceRange];
        
        *aLocationPointer = NSMaxRange(aDigitSequenceRange);
        
        return YES;
    }
    
    return NO;
}

+ (NUUInt64)intFromString:(NSString *)aString withRange:(NSRange)aDecimalDigitsRange
{
    NUUInt64 aValue = 0;
    
    for (NSUInteger aLocation = aDecimalDigitsRange.location; NSLocationInRange(aLocation, aDecimalDigitsRange) ; aLocation++)
    {
        aValue *= 10;
        aValue += [aString characterAtIndex:aLocation] - '0';
    }
    
    return aValue;
}

- (instancetype)initWithType:(NUCLexicalElementType)aType ppNumber:(NUCDecomposedPreprocessingToken *)aPpNumber
{
    if (self = [super initWithType:aType])
    {
        _ppNumber = [aPpNumber retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_ppNumber release];
    
    [super dealloc];
}

@end
