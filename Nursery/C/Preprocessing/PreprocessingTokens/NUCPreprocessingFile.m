//
//  NUCPreprocessingFile.m
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/11/18.
//  Copyright © 2021 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingFile.h"
#import "NUCGroup.h"
#import "NUCControlLineDefine.h"
#import "NUCIdentifier.h"

#import <Foundation/NSDictionary.h>

@implementation NUCPreprocessingFile

+ (BOOL)preprocessingFileFrom:(NUCPreprocessingTokenStream *)aStream with:(NUCPreprocessor *)aPreprocessor into:(NUCPreprocessingFile **)aToken
{
    NUCGroup *aGroup = nil;

    if ([NUCGroup groupFrom:aStream with:aPreprocessor isSkipped:NO into:&aGroup])
    {
        if (aToken)
            *aToken = [self preprocessingFileWithGroup:aGroup];
        
        return YES;
    }
    
    return NO;
}

+ (instancetype)preprocessingFileWithGroup:(NUCGroup *)aGroup
{
    return [[[self alloc] initWithGroup:aGroup] autorelease];
}

- (instancetype)initWithGroup:(NUCGroup *)aGroup
{
    if (self = [super initWithType:NUCLexicalElementProcessingFileType])
    {
        group = [aGroup retain];
    }
    
    return self;
}

- (void)dealloc
{
    [group release];
    
    [super dealloc];
}

- (NUCGroup *)group
{
    return group;
}

@end