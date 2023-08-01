//
//  NUCPreprocessor.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2020/04/18.
//  Copyright © 2020年 Nursery-Framework. All rights reserved.
//

#import <Foundation/NSObject.h>

@class NSString, NSMutableDictionary, NSMutableArray;
@class NUCTranslator, NUCSourceFile, NUCControlLineDefine, NUCControlLineInclude, NUCIdentifier, NUCPpTokens, NUCConstantExpression, NUCPreprocessingToken;

@interface NUCPreprocessor : NSObject
{
    NUCTranslator *translator;
    NUCSourceFile *sourceFile;
    NSMutableDictionary *macroDefines;
}

- (instancetype)initWithTranslator:(NUCTranslator *)aTranslator;

- (NUCTranslator *)translator;
- (NUCSourceFile *)sourceFile;

- (NSMutableDictionary *)macroDefines;
- (NUCControlLineDefine *)macroDefineFor:(NUCIdentifier *)aMacroName;
- (void)setMacroDefine:(NUCControlLineDefine *)aMacroDefine;
- (BOOL)macroIsDefined:(NUCIdentifier *)aMacroName;

- (void)preprocessSourceFile:(NUCSourceFile *)aSourceFile;

- (void)include:(NUCControlLineInclude *)anInclude;
- (void)define:(NUCControlLineDefine *)aMacroDefine;

- (NSInteger)executeConstantExpression:(NUCConstantExpression *)aConstantExpression;

@end