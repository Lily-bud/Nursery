//
//  NUCPreprocessingToken.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/09.
//

#import "NUCLexicalElement.h"

@class NUCPreprocessor;
@class NSMutableArray;

@interface NUCPreprocessingToken : NUCLexicalElement

- (BOOL)isIdentifier;
- (BOOL)isStringLiteral;
- (BOOL)isCharacterConstant;
- (BOOL)isPpNumber;
- (BOOL)isPunctuator;
- (BOOL)isUndef;
- (BOOL)isLine;
- (BOOL)isError;
- (BOOL)isPragma;
- (BOOL)isControlNewline;
- (BOOL)isWhitespace;
- (BOOL)isNotWhitespace;
- (BOOL)isMacroInvocation;
- (BOOL)isPpTokensWithMacroInvocations;
- (BOOL)isOpeningParenthesis;
- (BOOL)isPlacemaker;
- (BOOL)isMacroArgument;

- (void)addUnexpandedPpTokensTo:(NSMutableArray *)aPpTokens;
- (void)addExpandedPpTokensTo:(NSMutableArray *)aPpTokens;

@end

