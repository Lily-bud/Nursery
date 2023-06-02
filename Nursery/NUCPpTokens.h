//
//  NUCPpTokens.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/02/07.
//  Copyright © 2021年 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingDirective.h"

@class NUCDecomposedPreprocessingToken, NUCPreprocessingTokenStream, NUCIdentifier;

@interface NUCPpTokens : NUCPreprocessingDirective
{
    NSMutableArray *ppTokens;
}

+ (BOOL)ppTokensFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCPpTokens **)aToken;

+ (instancetype)ppTokens;

- (void)add:(NUCDecomposedPreprocessingToken *)aPpToken;

- (NSMutableArray *)ppTokens;
- (NSUInteger)count;

- (BOOL)containsIdentifier:(NUCIdentifier *)anIdentifier;

- (void)enumerateObjectsUsingBlock:(void (^)(NUCDecomposedPreprocessingToken *aPpToken, NSUInteger anIndex, BOOL *aStop))aBlock;

@end
