//
//  NUCPreprocessingToken.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/09.
//

#import "NUCLexicalElement.h"

@class NUCPreprocessor;
@class NSMutableArray, NSMutableString;

@interface NUCPreprocessingToken : NUCLexicalElement

- (BOOL)isIdentifier;
- (BOOL)isConstant;
- (BOOL)isIntegerConstant;
- (BOOL)isStringLiteral;
- (BOOL)isCharacterConstant;
- (BOOL)isPpNumber;
- (BOOL)isPunctuator;
- (BOOL)isUnaryPlusOperator;
- (BOOL)isUnaryMinusOperator;
- (BOOL)isBitwiseComplementOperator;
- (BOOL)isLogicalNegationOperator;
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
- (BOOL)isConcatenatedToken;
- (BOOL)isHash;
- (BOOL)isHashHash;
- (BOOL)isComma;
- (BOOL)isPeriod;
- (BOOL)isQuestionMark;
- (BOOL)isColon;
- (BOOL)isEllipsis;
- (BOOL)isDirectiveName;
- (BOOL)isNonDirectiveName;
- (BOOL)isLogicalOROperator;
- (BOOL)isLogicalANDOperator;
- (BOOL)isInclusiveOROperator;
- (BOOL)isExclusiveOROperator;
- (BOOL)isBitwiseANDOperator;
- (BOOL)isInequalityOperator;
- (BOOL)isEqualityOperator;
- (BOOL)isEqualToOperator;
- (BOOL)isNotEqualToOperator;
- (BOOL)isRelationalOperator;
- (BOOL)isLessThanOperator;
- (BOOL)isGreaterThanOperator;
- (BOOL)isLessThanOrEqualToOperator;
- (BOOL)isGreaterThanOrEqualToOperator;
- (BOOL)isShiftOperator;
- (BOOL)isLeftShiftOperator;
- (BOOL)isRightShiftOperator;
- (BOOL)isAdditiveOperator;
- (BOOL)isAdditionOperator;
- (BOOL)isSubtractionOperator;
- (BOOL)isMultiplicativeOperator;
- (BOOL)isMultiplicationOperator;
- (BOOL)isDivisionOperator;
- (BOOL)isRemainderOperator;
- (BOOL)isUnaryOperator;
- (BOOL)isWhitespacesWithoutNewline;
- (BOOL)isNewLine;
- (BOOL)isNotNewLine;
- (BOOL)isClosingParenthesis;
- (BOOL)isPredefinedMacroVA_ARGS;

- (void)addUnexpandedPpTokensTo:(NSMutableArray *)aPpTokens;
- (void)addExpandedPpTokensTo:(NSMutableArray *)aPpTokens;

@end

