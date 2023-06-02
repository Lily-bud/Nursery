//
//  NUCPreprocessingFile.h
//  Nursery
//
//  Created by TAKATA Akifumi on 2021/11/18.
//  Copyright © 2021 Nursery-Framework. All rights reserved.
//

#import "NUCPreprocessingDirective.h"

@class NSMutableDictionary;
@class NUCPreprocessingTokenStream, NUCPreprocessor;
@class NUCGroup, NUCControlLineDefine, NUCIdentifier;

@interface NUCPreprocessingFile : NUCPreprocessingDirective
{
    NUCGroup *group;
    NSMutableDictionary *macros;
}

+ (BOOL)preprocessingFileFrom:(NUCPreprocessingTokenStream *)aStream into:(NUCPreprocessingFile **)aToken;
+ (instancetype)preprocessingFileWithGroup:(NUCGroup *)aGroup;

- (instancetype)initWithGroup:(NUCGroup *)aGroup;

- (NUCGroup *)group;

- (NSMutableDictionary *)macros;
- (NUCControlLineDefine *)macroFor:(NUCIdentifier *)aMacroName;
- (void)setMacro:(NUCControlLineDefine *)aMacro;

@end