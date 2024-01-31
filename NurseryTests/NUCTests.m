//
//  NUCTests.m
//  Nursery
//
//  Created by TAKATA Akifumi on 2020/04/19.
//

#import <XCTest/XCTest.h>

#import "NUCTranslator.h"
#import "NUCSourceFile.h"

@interface NUCTests : XCTestCase

@end

@implementation NUCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testTranslationPhase1to2
{
    NSBundle *aBundle = [NSBundle bundleForClass:[self class]];
    NSURL *aPhysicalSourceFileURL = [aBundle URLForResource:@"CTranslationPhase1to2Example" withExtension:NULL subdirectory:NULL];
    NSURL *anExpectedLogicalSourceFileURL = [aBundle URLForResource:@"ExpectedCTranslationPhase1to2Example" withExtension:NULL subdirectory:NULL];

    NUCTranslator *aCTranslator = [[[NUCTranslator alloc] initWithSourceFileURLs:[NSArray arrayWithObject:aPhysicalSourceFileURL]] autorelease];
    NUCSourceFile *aSourceFile = nil;
    NSString *anExpectedLogicalSourceString = [NSString stringWithContentsOfURL:anExpectedLogicalSourceFileURL usedEncoding:NULL error:NULL];
    
    [aCTranslator translate];
    
    aSourceFile = [[aCTranslator preprocessedSourceFiles] firstObject];
    XCTAssertEqualObjects([aSourceFile logicalSourceString], anExpectedLogicalSourceString);
}

- (void)testTranslationPhase1to3
{
    NSBundle *aBundle = [NSBundle bundleForClass:[self class]];
    NSURL *aPhysicalSourceFileURL = [aBundle URLForResource:@"CommentExample" withExtension:NULL subdirectory:NULL];
//    NSURL *anExpectedLogicalSourceFileURL = [aBundle URLForResource:@"ExpectedCTranslationPhase1to2Example" withExtension:NULL subdirectory:NULL];
    
    NUCTranslator *aCTranslator = [[[NUCTranslator alloc] initWithSourceFileURLs:[NSArray arrayWithObject:aPhysicalSourceFileURL]] autorelease];
    NUCSourceFile *aSourceFile = nil;
//    NSString *anExpectedLogicalSourceString = [NSString stringWithContentsOfURL:anExpectedLogicalSourceFileURL usedEncoding:NULL error:NULL];
    
    [aCTranslator translate];
}

- (void)testTranslationPhase1to4
{
    NSBundle *aBundle = [NSBundle bundleForClass:[self class]];
    NSURL *aPhysicalSourceFileURL = [aBundle URLForResource:@"MacroExample" withExtension:NULL subdirectory:NULL];
    NUCTranslator *aCTranslator = [[[NUCTranslator alloc] initWithSourceFileURLs:[NSArray arrayWithObject:aPhysicalSourceFileURL]] autorelease];
    [aCTranslator setSearchPathURLs:[NSArray arrayWithObject:[aBundle resourceURL]]];
    
    [aCTranslator translate];
}

@end
