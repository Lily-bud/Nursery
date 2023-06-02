//
//  NUCPreprocessingToken.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/01.
//  Copyright © 2021年 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingToken.h"

@class NUCPreprocessingTokenStream, NUCReplacementList, NUCIdentifier;

@interface NUCDecomposedPreprocessingToken : NUCPreprocessingToken <NSCopying>
{
    NSString *content;
    NSRange range;
    NUCReplacementList *replacementList;
}

+ (BOOL)ellipsisFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCDecomposedPreprocessingToken **)aToken;


+ (instancetype)preprocessingTokenWithContentFromString:(NSString *)aString range:(NSRange)aRange type:(NUCLexicalElementType)anElementType;

+ (instancetype)preprocessingTokenWithContent:(NSString *)aString range:(NSRange)aRange type:(NUCLexicalElementType)anElementType;

- (instancetype)initWithContentFromString:(NSString *)aString range:(NSRange)aRange type:(NUCLexicalElementType)anElementType;

- (instancetype)initWithContent:(NSString *)aContent range:(NSRange)aRange type:(NUCLexicalElementType)anElementType;


- (NSString *)content;
- (NSRange)range;

- (NUCReplacementList *)replacementList;
- (void)setReplacementList:(NUCReplacementList *)aReplacementList;

- (BOOL)isHash;
- (BOOL)isIdentifier;
- (BOOL)isStringLiteral;
- (BOOL)isCharacterConstant;
- (BOOL)isPpNumber;
- (BOOL)isPunctuator;
- (BOOL)isComma;
- (BOOL)isPeriod;
- (BOOL)isQuestionMark;
- (BOOL)isColon;
- (BOOL)isEllipsis;
- (BOOL)isUndef;
- (BOOL)isLine;
- (BOOL)isError;
- (BOOL)isPragma;
- (BOOL)isDirectiveName;
- (BOOL)isNonDirectiveName;
- (BOOL)isControlNewline;
- (BOOL)isLogicalOROperator;
- (BOOL)isLogicalANDOperator;
- (BOOL)isInclusiveOROperator;
- (BOOL)isExclusiveOROperator;
- (BOOL)isBitwiseANDOperator;
- (BOOL)isInequalityOperator;
- (BOOL)isEqualityOperator;
- (BOOL)isRelationalOperator;
- (BOOL)isShiftOperator;
- (BOOL)isAdditiveOperator;
- (BOOL)isMultiplicativeOperator;
- (BOOL)isUnaryOperator;
- (BOOL)isWhitespace;
- (BOOL)isNotWhitespace;
- (BOOL)isWhitespacesWithoutNewline;
- (BOOL)isNewLine;
- (BOOL)isNotNewLine;

@end