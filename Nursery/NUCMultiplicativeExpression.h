//
//  NUCMultiplicativeExpression.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/21.
//  Copyright © 2021年 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingToken.h"

@class NUCCastExpression, NUCDecomposedPreprocessingToken, NUCPreprocessingTokenStream;

@interface NUCMultiplicativeExpression : NUCPreprocessingToken
{
    NUCCastExpression *castExpression;
    NUCMultiplicativeExpression *multiplicativeExpression;
    NUCDecomposedPreprocessingToken *multiplicativeOperator;
}

+ (BOOL)multiplicativeExpressionFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCMultiplicativeExpression **)aToken;

+ (instancetype)expressionWithCastExpression:(NUCCastExpression *)aCastExpression;

+ (instancetype)expressionWithMultiplicativeExpression:(NUCMultiplicativeExpression *)aMultiplicativeExpression multiplicativeOperator:(NUCDecomposedPreprocessingToken *)aMultiplicativeOperator castExpression:(NUCCastExpression *)aCastExpression;

- (instancetype)initWithCastExpression:(NUCCastExpression *)aCastExpression;

- (instancetype)initWithMultiplicativeExpression:(NUCMultiplicativeExpression *)aMultiplicativeExpression multiplicativeOperator:(NUCDecomposedPreprocessingToken *)aMultiplicativeOperator castExpression:(NUCCastExpression *)aCastExpression;

@end


