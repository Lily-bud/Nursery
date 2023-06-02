//
//  NUCControlLineDefine.m
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/11.
//  Copyright © 2021年 Nursery-Framework. All rights reserved.
//

#import "NUCControlLineDefine.h"
#import "NUCDecomposedPreprocessingToken.h"
#import "NUCControlLineDefineFunctionLike.h"
#import "NUCControlLineDefineObjectLike.h"
#import "NUCPreprocessingTokenStream.h"
#import "NUCIdentifier.h"
#import "NUCPreprocessor.h"

#import <Foundation/NSString.h>

@implementation NUCControlLineDefine

+ (BOOL)controlLineDefineFrom:(NUCPreprocessingTokenStream *)aPreprocessingTokenStream hash:(NUCDecomposedPreprocessingToken *)aHash directiveName:(NUCDecomposedPreprocessingToken *)aDirectiveName into:(NUCPreprocessingDirective **)aToken
{
    if (![[aDirectiveName content] isEqualToString:NUCPreprocessingDirectiveDefine])
        return NO;
    
    NUCDecomposedPreprocessingToken *anIdentifier = [aPreprocessingTokenStream next];
    
    if (!anIdentifier)
        return NO;
    
    NUCDecomposedPreprocessingToken *anLparen = [aPreprocessingTokenStream peekNext];

    if ([[anLparen content] isEqualToString:NUCOpeningParenthesisPunctuator])
    {
        [aPreprocessingTokenStream next];
        
        if ([NUCControlLineDefineFunctionLike controlLineDefineFunctionLikeFrom:aPreprocessingTokenStream hash:aHash directiveName:aDirectiveName identifier:anIdentifier lparen:anLparen into:aToken])
            return YES;
    }
    else
    {
        if ([NUCControlLineDefineObjectLike controlLineDefineObjectLikeFrom:aPreprocessingTokenStream hash:aHash directiveName:aDirectiveName identifier:anIdentifier into:aToken])
            return YES;
    }
    
    return NO;
}

+ (instancetype)defineWithHash:(NUCDecomposedPreprocessingToken *)aHash directiveName:(NUCDecomposedPreprocessingToken *)aDirectiveName identifier:(NUCIdentifier *)anIdentifier replacementList:(NUCReplacementList *)aReplacementList newline:(NUCNewline *)aNewline
{
    return [[[self alloc] initWithHash:aHash directiveName:aDirectiveName identifier:anIdentifier replacementList:aReplacementList newline:aNewline] autorelease];
}

- (instancetype)initWithHash:(NUCDecomposedPreprocessingToken *)aHash directiveName:(NUCDecomposedPreprocessingToken *)aDirectiveName identifier:(NUCIdentifier *)anIdentifier replacementList:(NUCReplacementList *)aReplacementList newline:(NUCNewline *)aNewline
{
    if (self = [super initWithType:NUCLexicalElementDefineType hash:aHash directiveName:aDirectiveName newline:aNewline])
    {
        identifier = [anIdentifier retain];
        replacementList = [aReplacementList retain];
    }
    
    return self;
}

- (void)dealloc
{
    [identifier release];
    [replacementList release];
    
    [super dealloc];
}

- (NUCIdentifier *)identifier
{
    return identifier;
}

- (NUCReplacementList *)replacementList
{
    return replacementList;
}

- (BOOL)isObjectLike
{
    return NO;
}

- (BOOL)isFunctionLike
{
    return NO;
}

- (BOOL)isEqual:(id)anObject
{
    NUCControlLineDefine *aDefine = (NUCControlLineDefine *)anObject;
    
    if (self == anObject)
        return YES;
    else if ([aDefine type] == NUCLexicalElementDefineType && [[self identifier] isEqual:[aDefine identifier]])
    {
        if (!(([self isObjectLike] && [aDefine isObjectLike]) || ([self isFunctionLike] && [aDefine isFunctionLike])))
            return NO;
        
        if ([self replacementList] && [aDefine replacementList])
            return [[self replacementList] isEqual:[aDefine replacementList]];
        else if (![self replacementList] && ![aDefine replacementList])
            return YES;
        else
            return NO;
    }
    else
        return NO;
}

- (void)preprocessWith:(NUCPreprocessor *)aPreprocessor
{
    [aPreprocessor define:self];
}

@end