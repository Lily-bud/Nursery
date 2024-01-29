//
//  NUCPreprocessingToken.m
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/01.
//

#import "NUCDecomposedPreprocessingToken.h"
#import "NUCPreprocessingTokenStream.h"
#import "NUCMacroInvocation.h"

#import <Foundation/NSString.h>

@implementation NUCDecomposedPreprocessingToken

static NUCDecomposedPreprocessingToken *whitespaceToken = nil;

+ (BOOL)ellipsisFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCDecomposedPreprocessingToken **)aToken
{
    NSUInteger aPosition = [aStream position];
    NUCDecomposedPreprocessingToken *anEllipsis = [aStream next];
    
    if ([anEllipsis isEllipsis])
    {
        if (aToken)
            *aToken = anEllipsis;
        
        return YES;
    }
    
    [aStream setPosition:aPosition];
    
    return NO;
}

+ (instancetype)whitespace
{
    if (!whitespaceToken)
        whitespaceToken = [[self alloc] initWithType:NUCLexicalElementWhiteSpaceCharacterType];
    
    return whitespaceToken;
}

+ (instancetype)preprocessingTokenWithContentFromString:(NSString *)aString range:(NSRange)aRange type:(NUCLexicalElementType)anElementType
{
    return [self preprocessingTokenWithContent:[aString substringWithRange:aRange] range:aRange type:anElementType];
}

+ (instancetype)preprocessingTokenWithContent:(NSString *)aContent range:(NSRange)aRange type:(NUCLexicalElementType)anElementType
{
    return [[[self alloc] initWithContent:aContent range:aRange type:anElementType] autorelease];
}

- (instancetype)initWithRange:(NSRange)aRange type:(NUCLexicalElementType)anElementType
{
    return [self initWithContent:nil range:aRange type:anElementType];
}

- (instancetype)initWithContentFromString:(NSString *)aString range:(NSRange)aRange type:(NUCLexicalElementType)anElementType
{
    return [self initWithContent:[aString substringWithRange:aRange] range:aRange type:anElementType];
}

- (instancetype)initWithContent:(NSString *)aContent range:(NSRange)aRange type:(NUCLexicalElementType)anElementType
{
    if (self = [super init])
    {
        content = [aContent copy];
        type = anElementType;
        range = aRange;
    }
    
    return self;
}

- (void)dealloc
{
    [content release];
    content = nil;
    
    [super dealloc];
}

- (NSString *)content
{
    return content;
}

- (NSRange )range
{
    return range;
}

- (NSString *)string
{
    if ([self isWhitespace])
        return NUCSpace;
    else
        return [self content];
}

- (NSString *)stringForSubstitution
{
    return [self string];
}

- (void)addStringTo:(NSMutableString *)aString
{
    [aString appendString:[self string]];
}

- (void)addStringForConcatinationTo:(NSMutableString *)aString
{
    [self addStringTo:aString];
}

- (NSUInteger)hash
{
    return [[self content] hash];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithContent:[self content] range:[self range] type:[self type]];
}

- (BOOL)isHash
{
    return [self type] == NUCLexicalElementPunctuatorType
                && [[self content] isEqualToString:NUCHash];
}

- (BOOL)isHashHash
{
    return [self type] == NUCLexicalElementPunctuatorType
                && [[self content] isEqualToString:NUCHashHash];
}

- (BOOL)isComma
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCCommaPunctuator];
}

- (BOOL)isPeriod
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCPeriod];
}

- (BOOL)isQuestionMark
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCQuestionMarkPunctuator];
}

- (BOOL)isColon
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCColonPunctuator];
}

- (BOOL)isEllipsis
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCEllipsis];
}

- (BOOL)isDirectiveName
{
    return [[[self class] NUCPreprocessingDirectiveNames] containsObject:[self content]];
}

- (BOOL)isNonDirectiveName
{
    return ![self isDirectiveName];
}

- (BOOL)isLogicalOROperator
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCLogicalOROperator];
}

- (BOOL)isLogicalANDOperator
{
    return [self isPunctuator]
                && [[self content] isEqualToString:NUCLogicalANDOperator];
}

- (BOOL)isInclusiveOROperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCInclusiveOROperator];
}

- (BOOL)isExclusiveOROperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCExclusiveOROperator];
}

- (BOOL)isBitwiseANDOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCBitwiseANDOperator];
}

- (BOOL)isInequalityOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCInequalityOperator];
}

- (BOOL)isEqualityOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCEqualityOperator];
}

- (BOOL)isEqualToOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCEqualityOperator];
}

- (BOOL)isNotEqualToOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCInequalityOperator];
}

- (BOOL)isRelationalOperator
{
    return [self isLessThanOperator] || [self isLessThanOrEqualToOperator]
        || [self isGreaterThanOperator] || [self isGreaterThanOrEqualToOperator];
}

- (BOOL)isLessThanOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCLessThanOperator];
}

- (BOOL)isGreaterThanOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCGreaterThanOperator];
}

- (BOOL)isLessThanOrEqualToOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCLessThanOrEqualToOperator];
}

- (BOOL)isGreaterThanOrEqualToOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCGreaterThanOrEqualToOperator];
}

- (BOOL)isShiftOperator;
{
    return [self isPunctuator] && ([[self content] isEqualToString:NUCLeftShiftOperator] || [[self content] isEqualToString:NUCRightShiftOperator]);
}

- (BOOL)isLeftShiftOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCLeftShiftOperator];
}

- (BOOL)isRightShiftOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCRightShiftOperator];
}

- (BOOL)isAdditiveOperator
{
    return [self isPunctuator] && ([[self content] isEqualToString:NUCAdditionOperator] || [[self content] isEqualToString:NUCSubtractionOperator]);
}

- (BOOL)isAdditionOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCAdditionOperator];
}

- (BOOL)isSubtractionOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCSubtractionOperator];
}

- (BOOL)isMultiplicativeOperator
{
    return [self isPunctuator] && ([[self content] isEqualToString:NUCMultiplicationOperator] || [[self content] isEqualToString:NUCDivisionOperator] || [[self content] isEqualToString:NUCRemainderOperator]);
}

- (BOOL)isMultiplicationOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCMultiplicationOperator];
}

- (BOOL)isDivisionOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCDivisionOperator];
}

- (BOOL)isRemainderOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCRemainderOperator];
}

- (BOOL)isUnaryOperator
{
    return [self isUnaryPlusOperator] || [self isUnaryMinusOperator] || [self isBitwiseComplementOperator] || [self isLogicalNegationOperator];
}

- (BOOL)isUnaryPlusOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCUnaryPlusOperator];
}

- (BOOL)isUnaryMinusOperator
{
    return [self isPunctuator] && [[self content] isEqualToString:NUCUnaryMinusOperator];
}

- (BOOL)isWhitespacesWithoutNewline
{
    return [self isWhitespace] && [self isNotNewLine];
}

- (BOOL)isNewLine
{
    return  [[self content] isEqualToString:NUCLF] || [[self content] isEqualToString:NUCCR] || [[self content] isEqualToString:NUCCRLF];
}

- (BOOL)isNotNewLine
{
    return ![self isNewLine];
}

- (BOOL)isOpeningParenthesis
{
    return [[self content] isEqual:NUCOpeningParenthesisPunctuator];
}

- (BOOL)isClosingParenthesis
{
    return [[self content] isEqual:NUCClosingParenthesisPunctuator];
}

- (BOOL)isBitwiseComplementOperator
{
    return [self isPunctuator] && [[self content] isEqual:NUCBitwiseComplementOperator];
}

- (BOOL)isLogicalNegationOperator
{
    return [self isPunctuator] && [[self content] isEqual:NUCLogicalNegationOperator];
}

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@", content:%@, range:%@", [self content], NSStringFromRange([self range])];
}

- (BOOL)isEqual:(id)anOther
{
    if (anOther == self)
        return YES;

    NUCDecomposedPreprocessingToken *aToken = anOther;
        
    return [[self content] isEqual:[aToken content]];
}

- (void)addPreprocessedStringTo:(NSMutableString *)aString with:(NUCPreprocessor *)aPreprocessor
{
    NSString *aContent = [self content];
    if (aContent)
        [aString appendString:aContent];
}

@end
