//
//  NUCExpression.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/12.
//  Copyright © 2021年 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingToken.h"

@class NUCConditionalExpression, NUCPreprocessingTokenStream;

@interface NUCExpression : NUCPreprocessingToken
{
    NUCConditionalExpression *conditionalExpression;
}

+ (BOOL)expressionFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCExpression **)aToken;

+ (instancetype)expressionWithConditionalExpression:(NUCConditionalExpression *)aConditionalExpression;

- (instancetype)initWithConditionalExpression:(NUCConditionalExpression *)aConditionalExpression;

@end

